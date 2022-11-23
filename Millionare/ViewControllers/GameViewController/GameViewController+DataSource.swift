//
//  GameViewController+DataSource.swift
//  Millionare
//
//  Created by Константин on 23.11.2022.
//

import UIKit

extension GameViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "AnswerCell", for: indexPath) as? AnswerCell else { return AnswerCell() }
        
        return cell
    }
    
    
}
