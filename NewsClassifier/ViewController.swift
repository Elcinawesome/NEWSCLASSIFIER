//Copyright (c) 2021 Elcin Yutes  (Tech-E-Pedia)
//

import UIKit
import WebKit
import DocumentClassifier

extension Classification.Category {

    var color: UIColor {
        return UIColor(named: rawValue) ?? UIColor(named: "App") ?? .darkGray
    }

}

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var classificationLabel: UILabel!
    @IBOutlet weak var classificationLabelBottomConstraint: NSLayoutConstraint!
    
    let classifier = DocumentClassifier()

    lazy var percentFormatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .percent
        formatter.maximumFractionDigits = 1
        return formatter
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        addKeyboardObservers()
        configureTextView()
    }

    func classify(_ text: String) {
        guard let classification = classifier.classify(text) else { return }
        let prediction = classification.prediction
        updateInterface(for: prediction)
    }

    func updateInterface(for prediction: Classification.Result) {
        guard let percent = percentFormatter.string(from: NSNumber(value: prediction.probability)) else { return }
        classificationLabel.text = prediction.category.rawValue + " " + "(\(percent))"
        changeInterfaceColor(to: prediction.category.color)
    }

    func configureTextView() {
        textView.layer.cornerRadius = 8
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.black.cgColor
    }

    @IBAction func clearButtonTapped(_ sender: Any) {
        textView.text = ""
        classificationLabel.text = "None"
        changeInterfaceColor(to: UIColor(named: "App"))
    }

    func changeInterfaceColor(to color: UIColor?) {
        classificationLabel.backgroundColor = color
        navigationController?.navigationBar.barTintColor = color
    }

}

// MARK: - UITextViewDelegate

extension ViewController: UITextViewDelegate {

    func textViewDidChange(_ textView: UITextView) {
        classify(textView.text)
    }

}

// MARK: - Keyboard

extension ViewController {

    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(toggleKeyboard), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(toggleKeyboard), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    @objc private func toggleKeyboard(for notification: Notification) {
        guard let attributes = keyboardAttributes(for: notification) else { return }
        UIView.animate(withDuration: attributes.animationDuration) {
            self.classificationLabelBottomConstraint.constant = -attributes.size.height
            self.view.layoutIfNeeded()
        }
    }

    private func keyboardAttributes(for notification: Notification) -> (size: CGSize, animationDuration: Double)? {
        guard
            let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as AnyObject).cgRectValue?.size,
            let animationDuration = (notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as AnyObject).doubleValue
            else { return nil }
        return (keyboardSize, animationDuration)
    }

}

