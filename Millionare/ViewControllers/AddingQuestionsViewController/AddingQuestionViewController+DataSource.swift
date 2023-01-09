//
//  AddingQuestionsViewController+DataSource.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

extension AddingQuestionsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberQuestions
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddingQuestionsCell.identifier, for: indexPath) as? AddingQuestionsCell else { return UITableViewCell() }
        cell.delegate = self
        cell.set(numberQuestion: (indexPath.row + 1))
        emptyQuestions[indexPath.row] = true
        emptyAnswers[indexPath.row] = true
        correctAnswers[indexPath.row] = .incorrect
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddingQuestionsFooterView.identifier) as? AddingQuestionsFooterView else { return nil }
        footer.delegate = self
        return footer
    }
}
