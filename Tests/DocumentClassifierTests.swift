//Copyright (c) 2021 Elcin Yutes  (Tech-E-Pedia)

import XCTest
@testable import DocumentClassifier

class DocumentClassifierTests: XCTestCase {

    let classifier = DocumentClassifier()
    let categories = ["Business", "Entertainment", "Politics", "Sports", "Technology"]

    let bundle = Bundle(for: DocumentClassifierTests.self)
    
    func testClassifiy() {
        categories.forEach {
            let path = bundle.path(forResource: $0, ofType: "txt")!
            let url = URL(fileURLWithPath: path)
            let text = try! String(contentsOf: url)
            let classification = classifier.classify(text)!
            let expectedCategory = Classification.Category(rawValue: $0)!
            XCTAssertEqual(classification.prediction.category, expectedCategory)
        }
        XCTAssertNil(classifier.classify("technology"))
    }

    func testNilClassificationFromOutput() {
        let output = DocumentClassificationOutput(classLabel: "random", classProbability: ["random": 0.4])
        XCTAssertNil(Classification(output: output))
    }

    func testNilResultFromClassProbability() {
        XCTAssertNil(Classification.result(from: ("random", 0.4)))
    }

}
