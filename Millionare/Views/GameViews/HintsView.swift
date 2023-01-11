//
//  HintsView.swift
//  Millionare
//
//  Created by Константин on 02.12.2022.
//

import UIKit

protocol HintsViewDelegate: AnyObject {
    func use(hint: Hint)
}

class HintsView: UITableViewHeaderFooterView {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: HintsView.self)
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    weak var delegate: HintsViewDelegate?
    
    // MARK: - Private properties
    
    private lazy var hintsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        return label
    }()
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.backgroundColor = .white
        stack.distribution = .fillEqually
        return stack
    }()
    
    // MARK: - Construction
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func configure(hintsLabelText text: String) {
        hintsLabel.text = text
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        hintsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hintsLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(stackView)
        let hintsLabelTrailingConstraint = hintsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets)
        hintsLabelTrailingConstraint.priority = UILayoutPriority(999)
        let hintsLabelBottomConstraint =
        hintsLabel.bottomAnchor.constraint(equalTo: stackView.topAnchor, constant: -insets)
        hintsLabelBottomConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            hintsLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets),
            hintsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            hintsLabelTrailingConstraint,
            hintsLabelBottomConstraint
        ])
        
        for hint in Hint.allCases.enumerated() {
            let button = UIButton()
            button.setImage(UIImage(systemName: hint.element.icon), for: .normal)
            button.tag = hint.offset
            button.tintColor = .systemGreen
            button.backgroundColor = .white
            button.addTarget(self,
                             action: #selector(hintButtonTap),
                             for: .touchUpInside)
            stackView.addArrangedSubview(button)
        }
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets)
                                    ])
    }
    
    @objc private func hintButtonTap(_ sender: UIButton) {
        switch sender.tag {
        case 0: //звонок другу
            if Game.shared.gameSession?.hintCallFriend == true {
                sender.tintColor = .systemRed
                Game.shared.gameSession?.hintCallFriend = false
                delegate?.use(hint: .callFriend)
            }
        case 1: //помощь зала
            if Game.shared.gameSession?.hintHallHelp == true {
                sender.tintColor = .systemRed
                Game.shared.gameSession?.hintHallHelp = false
                delegate?.use(hint: .hallHelp)
            }
        case 2: //50/50
            if Game.shared.gameSession?.hintFiftyFifty == true {
                sender.tintColor = .systemRed
                Game.shared.gameSession?.hintFiftyFifty = false
                delegate?.use(hint: .fiftyFifty)
            }
        default:
            print("default")
        }
    }
}
