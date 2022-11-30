//
//  ResultViewController.swift
//  Millionare
//
//  Created by Константин on 29.11.2022.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.register(ResultCell.self, forCellReuseIdentifier: ResultCell.identifier)
        tableView.backgroundColor = .white
        return tableView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
