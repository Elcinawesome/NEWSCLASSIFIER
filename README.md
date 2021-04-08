# NewsClassifier

![CocoaPods Version](https://cocoapod-badges.herokuapp.com/v/DocumentClassifier/badge.png) [![Swift](https://img.shields.io/badge/swift-5.0-orange.svg?style=flat)](https://developer.apple.com/swift/) ![Platform](https://cocoapod-badges.herokuapp.com/p/DocumentClassifier/badge.png)

## Overview

NewsClassifierClassifier is a Swift framework for classifying documents into one of five categories (Business, Entertainment, Politics, Sports, and Technology). It uses a CoreML model trained with 1,500 news articles from the BBC.

## Features

- iOS 11.0+, macOS 10.13+, tvOS 11.0+, watchOS 4.0+
- 100% Test Coverage
- Best CV Score: 0.965333333333

## Usage

[Swift 4 Released (Sample Article](https://swift.org/blog/swift-4-0-released/))

```swift
let text = articleText
guard let classification = classifier.classify(text) else { return }
print(classification.prediction) // Technology: 0.42115752953489294
print(classification.allResults) // Business: 0.141, Entertainment: 0.138, Politics: 0.113, Sports: 0.187, Technology: 0.421
```

## Model

- [Model Link](https://github.com/toddkramer/DocumentClassifier/blob/master/Sources/DocumentClassification.mlmodel)
- Best CV Score: 0.965333333333
- Trained using 1,500 news articles from the BBC from 2004-2005 (see references)
- Converted from [scikit-learn Pipeline](http://scikit-learn.org/stable/modules/generated/sklearn.pipeline.Pipeline.html) using [coremltools](https://pypi.python.org/pypi/coremltools).
- Based on the [LinearSVC](http://scikit-learn.org/stable/modules/generated/sklearn.svm.LinearSVC.html) classifier.

## Author

ELCIN YUTES 

## References
- [BBC Datasets](http://mlg.ucd.ie/datasets/bbc.html)
