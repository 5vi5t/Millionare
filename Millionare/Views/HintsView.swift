//
//  HintsView.swift
//  Millionare
//
//  Created by Константин on 02.12.2022.
//

import UIKit

class HintsView: UITableViewHeaderFooterView {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: HintsView.self)
    
    // MARK: - Properties
    
    let insets: CGFloat = 8
    
    // MARK: - Private properties
    
    private lazy var hintsLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = .black
        label.backgroundColor = .white
        return label
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
    
    func setHintsLabel(text: String) {
        hintsLabel.text = text
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        hintsLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(hintsLabel)
        let hintsLabelTrailingConstraint = hintsLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -insets)
        hintsLabelTrailingConstraint.priority = UILayoutPriority(999)
        let hintsLabelBottomConstraint =
        hintsLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -insets)
        hintsLabelBottomConstraint.priority = UILayoutPriority(999)
        
        NSLayoutConstraint.activate([
            hintsLabel.topAnchor.constraint(equalTo: topAnchor, constant: insets),
            hintsLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: insets),
            hintsLabelTrailingConstraint,
            hintsLabelBottomConstraint
        ])
    }
}
