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
    
    // MARK: - Private properties
    
    private lazy var settingsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
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
        control.selectedSegmentIndex = {
            switch Game.shared.orderQuestions {
            case .serial:
                return 0
            case .random:
                return 1
            }
        }()
        control.addTarget(self, action: #selector(orderQuestionsControlTap), for: .valueChanged)
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
            settingsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SettingsOrderQuestionsCell.insets),
            settingsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -SettingsOrderQuestionsCell.insets),
            settingsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: SettingsOrderQuestionsCell.insets),
            settingsLabel.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: -SettingsOrderQuestionsCell.insets)
        ])
        
        contentView.addSubview(orderQuestionsControl)
        orderQuestionsControl.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            orderQuestionsControl.topAnchor.constraint(equalTo: contentView.topAnchor, constant: SettingsOrderQuestionsCell.insets),
            orderQuestionsControl.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -SettingsOrderQuestionsCell.insets),
            orderQuestionsControl.leadingAnchor.constraint(greaterThanOrEqualTo: contentView.centerXAnchor, constant: SettingsOrderQuestionsCell.insets),
            orderQuestionsControl.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -SettingsOrderQuestionsCell.insets)
        ])
    }
    
    @objc private func orderQuestionsControlTap(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            Game.shared.orderQuestions = .serial
        case 1:
            Game.shared.orderQuestions = .random
        default:
            Game.shared.orderQuestions = .serial
        }
    }
}
