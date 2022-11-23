//
//  AnswerCell.swift
//  Millionare
//
//  Created by Константин on 23.11.2022.
//

import UIKit

class AnswerCell: UITableViewCell {
    
    // MARK: - Properties
    
    let horizontalInset: CGFloat = 18
    let verticalInset: CGFloat = 8
    
    // MARK: - Private properties
    
    private lazy var answerButton: UIButton = {
        let button = UIButton()
        button.setTitle("Ответ", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .blue
        return button
    }()
    
    // MARK: - Construction
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        contentView.addSubview(answerButton)
        answerButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            answerButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: verticalInset),
            answerButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -verticalInset),
            answerButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: horizontalInset),
            answerButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -horizontalInset)
        ])
    }
    
    // MARK: - UITableViewCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
