//
//  AddingQuestionsAnswerHeaderView.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

protocol AddingQuestionsAnswerHeaderViewDelegate: AnyObject {
    func setQuestion(text: String)
}

class AddingQuestionsAnswerHeaderView: UITableViewHeaderFooterView {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AddingQuestionsAnswerHeaderView.self)
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    weak var delegate: AddingQuestionsAnswerHeaderViewDelegate?
    
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
    private(set) var numberQuestion = 0 {
        didSet {
            questionLabel.text = "Вопрос \(numberQuestion)"
            questionTextField.placeholder = "Сюда писать вопрос \(numberQuestion)"
        }
    }
    private var questionText: String = "" {
        didSet {
            delegate?.setQuestion(text: questionText)
        }
    }
    
    // MARK: - Construction
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    func set(numberQuestion: Int) {
        self.numberQuestion = numberQuestion
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        questionTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(questionLabel)
        contentView.addSubview(questionTextField)
        let questionLabelTrailingConstraint = questionLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets)
        questionLabelTrailingConstraint.priority = UILayoutPriority(999)
        let questionLabelBottomConstraint =
        questionLabel.bottomAnchor.constraint(equalTo: questionTextField.topAnchor, constant: -insets)
        questionLabelBottomConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insets),
            questionLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            questionLabelTrailingConstraint,
            questionLabelBottomConstraint,
            questionTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            questionTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets),
            questionTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -insets)
        ])
    }
}

// MARK: - Text Field Delegate

extension AddingQuestionsAnswerHeaderView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            questionText = text
        }
    }
}
