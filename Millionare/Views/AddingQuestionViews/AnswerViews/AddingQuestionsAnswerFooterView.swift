//
//  AddingQuestionsAnswerFooterView.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

protocol AddingQuestionsAnswerFooterViewDelegate: AnyObject {
    func addAnswer()
}

class AddingQuestionsAnswerFooterView: UITableViewHeaderFooterView {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AddingQuestionsAnswerFooterView.self)
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    weak var delegate: AddingQuestionsAnswerFooterViewDelegate?
    
    // MARK: - Private properties
    
    private lazy var addAnswerButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Добавить ответ", for: .normal)
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
                         action: #selector(addAnswerButtonTap),
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
    
    @objc private func addAnswerButtonTap() {
        delegate?.addAnswer()
    }
}