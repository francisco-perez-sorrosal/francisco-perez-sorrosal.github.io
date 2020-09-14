---
layout: post
title:  "Paper Accepted as a Poster in ACL 2019: Hierarchical Transfer Learning for Multi-label Text Classification"
date:   2019-05-14 11:35:00 -0700
categories: nlp deep learning pytorch hierarchical transfer learning
---

Happy to learn that our paper ["Hierarchical Transfer Learning for Multi-label Text Classification"](https://www.aclweb.org/anthology/P19-1633/)
has been accepted as a poster in ACL 2019! Thanks and congrats Sidd, Cem & Kostas!!!


### Abstract
Multi-Label Hierarchical Text Classification (MLHTC) is the task of categorizing documents into one or more topics 
organized in an hierarchical taxonomy. MLHTC can be formulated by combining multiple binary classification problems with
an independent classifier for each category. We propose a novel transfer learning based strategy, HTrans, where 
binary classifiers at lower levels in the hierarchy are initialized using parameters of the parent classifier and 
fine-tuned on the child category classification task. In HTrans, we use a Gated Recurrent Unit (GRU)-based deep learning
architecture coupled with attention. Compared to binary classifiers trained from scratch, our HTrans approach results in 
significant improvements of 1% on micro-F1 and 3% on macro-F1 on the RCV1 dataset. Our experiments also show that 
binary classifiers trained from scratch are significantly better than single multi-label models.

### Citation

```text
@inproceedings{banerjee-etal-2019-hierarchical,
    title = "Hierarchical Transfer Learning for Multi-label Text Classification",
    author = "Banerjee, Siddhartha  and
      Akkaya, Cem  and
      Perez-Sorrosal, Francisco  and
      Tsioutsiouliklis, Kostas",
    booktitle = "Proceedings of the 57th Annual Meeting of the Association for Computational Linguistics",
    month = jul,
    year = "2019",
    address = "Florence, Italy",
    publisher = "Association for Computational Linguistics",
    url = "https://www.aclweb.org/anthology/P19-1633",
    doi = "10.18653/v1/P19-1633",
    pages = "6295--6300",
}
```