//
//  AnswerCell.swift
//  Millionare
//
//  Created by Константин on 23.11.2022.
//

import UIKit

class AnswerCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AnswerCell.self)
    static let horizontalInset: CGFloat = 18
    static let verticalInset: CGFloat = 8
    
    // MARK: - Private properties
    
    private lazy var answerLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.textAlignment = .center
        label.numberOfLines = 0
        label.backgroundColor = .blue
        return label
    }()
    
    private(set) var correctAnswer: AnswerType = .incorrect
    private var hintType: HintType = .none {
        didSet {
            switch hintType {
            case .right:
                answerLabel.backgroundColor = .systemGreen
            case .wrong:
                answerLabel.backgroundColor = .systemRed
            case .none:
                answerLabel.backgroundColor = .blue
            }
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
    
    //MARK: - Functions
    
    func  configure(answerLabelText text: String, answerType: AnswerType, hintType: HintType) {
        answerLabel.text = text
        self.correctAnswer = answerType
        self.hintType = hintType
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        contentView.addSubview(answerLabel)
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AnswerCell.verticalInset),
            answerLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AnswerCell.verticalInset),
            answerLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AnswerCell.horizontalInset),
            answerLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AnswerCell.horizontalInset)
        ])
    }
    
    // MARK: - UITableViewCell
    
    override func prepareForReuse() {
        super.prepareForReuse()
        answerLabel.text = ""
        correctAnswer = .incorrect
        hintType = .none
    }
}
