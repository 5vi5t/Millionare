//
//  AddingQuestionHeaderView.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

class AddingQuestionHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AddingQuestionHeaderView.self)
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    var question: String = ""
    
    // MARK: - Private properties
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        label.text = "Вопрос"
        return label
    }()
    private lazy var questionTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сюда писать вопрос"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()
    
    // MARK: - Construction
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questionLabel)
        addSubview(questionTextField)
        let questionLabelTrailingConstraint = questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets)
        questionLabelTrailingConstraint.priority = UILayoutPriority(999)
        let questionLabelBottomConstraint =
        questionLabel.bottomAnchor.constraint(equalTo: questionTextField.topAnchor, constant: -insets)
        questionLabelBottomConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            questionLabelTrailingConstraint,
            questionLabelBottomConstraint,
            questionTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            questionTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets),
            questionTextField.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets)
        ])
    }
}

// MARK: - Text Field Delegate

extension AddingQuestionHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text,
           !text.isEmpty {
            question = text
        } else {
            question = ""
        }
    }
}
