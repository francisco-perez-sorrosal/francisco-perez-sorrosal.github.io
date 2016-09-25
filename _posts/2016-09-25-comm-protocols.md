---
layout: post
title:  "Communication Protocols and Frameworks for Writing Client-Server Apps"
date:   2016-09-25 11:35:00 -0700
categories: grpc netty akka rpc remote client server java
---

Back in June, I decided to try some of the new versions of some of the well-know communication protocols
and frameworks for writing client-server applications with Java for having some base code/scaffolding
for further use in my projects. The target protocols/frameworks are:

1. [Netty](http://netty.io/) (v4.1.1)
2. [GRPC](http://www.grpc.io/) (v0.15.0) Uses Netty internally for communication and [Protocol buffers](https://developers.google.com/protocol-buffers/)
for making it client-server communication laguage independent.
3. [Akka](http://akka.io/) (v2.4.7) Uses Netty for communicating remote actors.

In order to do that, I decided to create a client-server application that implements a silly time-service. The
goal here was not to focus on the functionality of the service, but to try the different protocols.
 
The server-side of the time service has multiple layers, and each one of them can be the target of the client request. 
The entry point for the client in the first layer of the server side offers the client the possibility to use either 
Netty or GRPC synchronously or asynchronously for getting the time. When making a request, the client can specify 
also the server-side layer from to get the time from, e.g. layer 0, 1, 2... Each layer has a local Akka actor that 
is responsible to get the time of the server and send it back to the previous layer. All intermediate layers but the 
last one in the pipeline have also a remote actor instance in order to forward the client request to the next layer if required.

The following figure shows a diagram of a possible deployment of the client-server app:

![Multi-layer Time Server App]({{site.baseurl}}/post-images/2016-09-25-comm-protocols/TimeApp.png)

The source code of the application can be found in my Github under the [comm-protocols project](https://github.com/francisco-perez-sorrosal/comm-protocols).
For communicating client and server with Netty, I just decided to use a simple text-based protocol, with TIME <layer> & DONE messages for
getting the time from a specific layer and close the communication channel respectively. For GRPC, I defined a simple service with
basic protobuf messages mimicking the text protocol for the raw Netty implementation. The protobuf file with the protocol definition is 
shown below:

{% highlight java linenos %}
{% github_file https://github.com/francisco-perez-sorrosal/comm-protocols/blob/master/protobuf/src/main/proto/control.proto %}
{% endhighlight %}


In order to deploy a server-side pipeline like the one shown in the figure above, these are the parameters that we should
provide:

1. For the Back Server in Layer 2
  * Run `com.fps.rpc.server.BackServer` class with parameters `-actorSystemName backActorSystem2 -nodeLevel 2 -conf backServer2`.
   This creates the actor system for layer 2 with the particular name and configuration provided.
2. For the Back Server in Layer 1
  * Run `com.fps.rpc.server.BackServer` class with parameters `-actorSystemName backActorSystem1 -nodeLevel 1 -remoteActor akka.tcp://backActorSystem2@127.0.0.1:2553/user/timeOracle`.
  This creates the actor system for layer 1 with the particular name and configuration provided and stating that this
  layer is communicating with the layer 2 through the remote actor specified.
2. For the entry Time Server in Layer 0
  * Run `com.fps.rpc.FrontServer` class with the default parameters (In the current version the forwarding actor it's
  hardcoded to communicate with the time server in the next layer `akka.tcp://backActorSystem1@127.0.0.1:2552/user/timeOracle`)

In order to try the service, two client implementations are provided, the raw Netty and the GRPC. These are the parameters 
required for each one of them:

1. For Netty
  * Run `com.fps.rpc.client.MainClient` class with parameters `netty -serverHostPort localhost:64444 -nodeLevel 2`. Of course, you
  can try different node levels for changing the target layer.
2. For GRPC
  * Run `com.fps.rpc.client.MainClient` class with parameters `grpc -serverHostPort localhost:65444 -nodeLevel 2 -requestType async`.
  As in the Netty client, we can specify the target layer and here also if we want to perform the request either synchronously or
  asynchronously.
 
For example, when executing the GRPC client with the parameters specified above, we should see a response similar to this:

```
Sep 25, 2016 1:44:30 PM io.grpc.internal.ManagedChannelImpl <init>
INFO: [ManagedChannelImpl@598067a5] Created with target localhost:65444
16/09/25 13:44:30 [main] INFO grpc.GRPCClient: GRPC channel created. Target host localhost:65444
16/09/25 13:44:30 [main] INFO grpc.GRPCClient: Checking time asynchronously
16/09/25 13:44:31 [grpc-default-executor-0] INFO grpc.GRPCClient: Time checked asynchronously: akka://backActorSystem2/user/timeOracle 2016-09-25 13:44:31
16/09/25 13:44:31 [grpc-default-executor-0] INFO grpc.GRPCClient: Request Completed
Sep 25, 2016 1:44:31 PM io.grpc.internal.ManagedChannelImpl maybeTerminateChannel
INFO: [ManagedChannelImpl@598067a5] Terminated
```

It is also possible to exercise the server side using `telnet` and text commands directly in the console. To do that,
just:

```sh
$ telnet localhost 64444
Trying ::1...
Connected to localhost.
Escape character is '^]'.
```

And then insert the commands in text like this:

```
TIME 0
```

You should get a responses like this:

```
TIME 0
akka://frontServerActorSystem/user/requestForwarder/oracle 2016-09-25 13:50:34

TIME 1
akka://backActorSystem1/user/timeOracle 2016-09-25 13:52:44

TIME 2
akka://backActorSystem2/user/timeOracle 2016-09-25 13:53:03
```

To finish the client-server communication, the command `DONE` can be used in the `telnet` command.