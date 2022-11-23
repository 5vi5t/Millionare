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
    
    private let tableView = UITableView()

    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupView()
    }
    
    // MARK: - Functions
    
    
    // MARK: - Private functions
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.backgroundColor = .white
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
