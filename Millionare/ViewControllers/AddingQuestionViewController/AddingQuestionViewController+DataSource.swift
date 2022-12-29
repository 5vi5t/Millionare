//
//  AddingQuestionViewController+DataSource.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

extension AddingQuestionViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberAnswers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddingQuestionAnswerCell.identifier, for: indexPath) as? AddingQuestionAnswerCell else { return UITableViewCell() }
        cell.setAnswerNumber(indexPath.row + 1)
        cell.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddingQuestionHeaderView.identifier) as? AddingQuestionHeaderView else { return nil }
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddingQuestionFooterView.identifier) as? AddingQuestionFooterView else { return nil }
        footer.delegate = self
        return footer
    }
}
