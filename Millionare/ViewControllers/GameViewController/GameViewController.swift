//
//  GameViewController.swift
//  Millionare
//
//  Created by Константин on 23.11.2022.
//

import UIKit

class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    
    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.sizeHeaderToFit()
        tableView.sizeFooterToFit()
    }
    
    // MARK: - Functions
    
    
    // MARK: - Private functions
    
    private func setupView() {
        view.addSubview(tableView)
        view.backgroundColor = .white
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        tableView.register(AnswerCell.self, forCellReuseIdentifier: "AnswerCell")
        let headerView = QuestionView(text: "Вопрос")
        let footerView = QuestionView(text: "Подсказки")
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
