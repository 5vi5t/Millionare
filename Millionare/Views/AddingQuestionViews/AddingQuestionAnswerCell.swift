//
//  AddingQuestionAnswerCell.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

class AddingQuestionAnswerCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AddingQuestionAnswerCell.self)
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    
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
        control.selectedSegmentIndex = 1
        control.addTarget(self, action: #selector(answerTypeControlTap), for: .valueChanged)
        return control
    }()
    private(set) var answerNumber = 0 {
        didSet {
            answerLabel.text = "Ответ \(answerNumber)"
            answerTextField.placeholder = "Сюда писать ответ \(answerNumber)"
        }
    }
    private weak var mediator: Mediator?
    
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
    
    func set(mediator: Mediator) {
        self.mediator = mediator
        mediator.addColleague(self)
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
    
    @objc private func answerTypeControlTap() {
        mediator?.sendMessage("го я создал", by: self)
    }
    
    // MARK: - UITableViewCell
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
}

extension AddingQuestionAnswerCell: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return endEditing(true)
    }
}

extension AddingQuestionAnswerCell: Colleague {
    func colleague(_ colleague: Colleague, didSendMessage message: String) {
        answerTypeControl.selectedSegmentIndex = 1
    }
}
