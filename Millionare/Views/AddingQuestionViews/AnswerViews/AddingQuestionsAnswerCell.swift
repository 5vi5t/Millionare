//
//  AddingQuestionsAnswerCell.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

protocol AddingQuestionsAnswerCellDelegate: AnyObject {
    func setAnswer(type: AnswerType, forAnswerNumber number: Int)
    func setAnswer(text: String, forAnswerNumber number: Int)
}

class AddingQuestionsAnswerCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AddingQuestionsAnswerCell.self)
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    weak var delegate: AddingQuestionsAnswerCellDelegate?
    
    // MARK: - Private properties
    
    private lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        label.text = "Ответ \(answerNumber)"
        return label
    }()
    private lazy var answerTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Сюда писать ответ \(answerNumber)"
        textField.borderStyle = .roundedRect
        textField.delegate = self
        return textField
    }()
    private lazy var answerTypeControl: UISegmentedControl = {
        var items: [String] = []
        for type in AnswerType.allCases {
            let item = type.description
            items.append(item)
        }
        let control = UISegmentedControl(items: items)
        control.selectedSegmentIndex = answerType.rawValue
        control.addTarget(self, action: #selector(answerTypeControlTap(_:)), for: .valueChanged)
        return control
    }()
    private(set) var answerNumber = 0 {
        didSet {
            answerLabel.text = "Ответ \(answerNumber)"
            answerTextField.placeholder = "Сюда писать ответ \(answerNumber)"
        }
    }
    private(set) var answerType: AnswerType = .incorrect {
        didSet {
            answerTypeControl.selectedSegmentIndex = answerType.rawValue
            delegate?.setAnswer(type: answerType, forAnswerNumber: answerNumber)
        }
    }
    private var answerText = "" {
        didSet {
            delegate?.setAnswer(text: answerText, forAnswerNumber: answerNumber)
        }
    }
    
    // MARK: - Construction
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func setAnswerNumber(_ number: Int) {
        answerNumber = number
    }
    
    func setAnswerType(_ answerType: AnswerType) {
        self.answerType = answerType
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        answerTypeControl.translatesAutoresizingMaskIntoConstraints = false
        answerTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(answerLabel)
        contentView.addSubview(answerTypeControl)
        contentView.addSubview(answerTextField)
        
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insets),
            answerLabel.bottomAnchor.constraint(equalTo: answerTextField.topAnchor, constant: -insets),
            answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            
            answerTypeControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insets),
            answerTypeControl.bottomAnchor.constraint(equalTo: answerTextField.topAnchor, constant: -insets),
            answerTypeControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets),
            
            answerTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -insets),
            answerTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            answerTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets)
        ])
    }
    
    @objc private func answerTypeControlTap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case AnswerType.correct.rawValue:
            answerType = .correct
        case AnswerType.incorrect.rawValue:
            answerType = .incorrect
        default:
            answerType = .incorrect
        }
    }
    
    // MARK: - UITableViewCell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        answerTypeControl.selectedSegmentIndex = AnswerType.incorrect.rawValue
        answerText = ""
    }
}

// MARK: - Text Field Delegate

extension AddingQuestionsAnswerCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return endEditing(true)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if let text = textField.text {
            answerText = text
        }
    }
}
