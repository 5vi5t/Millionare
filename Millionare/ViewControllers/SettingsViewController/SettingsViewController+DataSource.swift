//
//  SettingsViewController+DataSource.swift
//  Millionare
//
//  Created by Константин on 01.12.2022.
//

import UIKit

extension SettingsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: SettingsOrderQuestionsCell.identifier, for: indexPath) as? SettingsOrderQuestionsCell else { return UITableViewCell() }
        return cell
    }
}
