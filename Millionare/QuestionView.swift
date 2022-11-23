//
//  QuestionView.swift
//  Millionare
//
//  Created by Константин on 23.11.2022.
//

import UIKit

class QuestionView: UIView {
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    
    //MARK: - Private properties
    
    private lazy var questionLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    
    // MARK: - Construction
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        questionLabel.text = text
    }
    
    // MARK: - Functions
    
    func setupView() {
        questionLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(questionLabel)
        let questionLabelTrailingConstraint = questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets)
        questionLabelTrailingConstraint.priority = UILayoutPriority(999)
        let questionLabelBottomConstraint =
        questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets)
        questionLabelBottomConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets),
            questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            questionLabelTrailingConstraint,
            questionLabelBottomConstraint
        ])
    }
}
