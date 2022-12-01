//
//  SettingsOrderQuestionsCell.swift
//  Millionare
//
//  Created by Константин on 01.12.2022.
//

import UIKit

class SettingsOrderQuestionsCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AnswerCell.self)
    static let insets: CGFloat = 8
    
    // MARK: - Properties
    
    var orderQuestions: OrderQuestions = .serial
    
    // MARK: - Private properties
    
    private var selectedOrderQuestions: OrderQuestions {
        switch orderQuestionsControl.selectedSegmentIndex {
        case 0:
            return .serial
        case 1:
            return .random
        default:
            return .serial
        }
    }
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        label.font = UIFont.systemFont(ofSize: 17)
        label.text = "Порядок вопросов"
        return label
    }()
    
    private lazy var orderQuestionsControl: UISegmentedControl = {
        var items: [String] = []
        for order in OrderQuestions.allCases {
            let item = order.description
            items.append(item)
        }
        let control = UISegmentedControl(items: items)
        return control
    }()
    
    // MARK: - Construction
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        contentView.addSubview(settingsLabel)
        settingsLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            settingsLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            settingsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SettingsOrderQuestionsCell.insets),
            settingsLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: -SettingsOrderQuestionsCell.insets)
        ])
        
        contentView.addSubview(orderQuestionsControl)
        orderQuestionsControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderQuestionsControl.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            orderQuestionsControl.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: SettingsOrderQuestionsCell.insets),
            orderQuestionsControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -SettingsOrderQuestionsCell.insets)
        ])
    }
}