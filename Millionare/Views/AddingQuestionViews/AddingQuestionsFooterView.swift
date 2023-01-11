//
//  AddingQuestionsFooterView.swift
//  Millionare
//
//  Created by Константин on 01.01.2023.
//

import UIKit

protocol AddingQuestionsFooterViewDelegate: AnyObject {
    func addQuestion()
}

class AddingQuestionsFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AddingQuestionsFooterView.self)
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    weak var delegate: AddingQuestionsFooterViewDelegate?
    
    // MARK: - Private properties
    
    private lazy var addAnswerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Добавить вопрос", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.setTitleShadowColor(
            .init(
                red: 0,
                green: 0,
                blue: 0,
                alpha: 0.5),
            for: .normal)
        button.titleLabel?.shadowOffset = CGSize(width: 0, height: 1)
        //TODO: - переделать кнопку с конфигурацией этой
        button.reversesTitleShadowWhenHighlighted = true
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 10
        button.addTarget(self,
                         action: #selector(addQuestionButtonTap),
                         for: .touchUpInside)
        return button
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
        addAnswerButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(addAnswerButton)
        
        NSLayoutConstraint.activate([
            addAnswerButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: insets),
            addAnswerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: insets),
            addAnswerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -insets),
            addAnswerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -insets)
        ])
    }
    
    @objc private func addQuestionButtonTap() {
        delegate?.addQuestion()
    }
}
