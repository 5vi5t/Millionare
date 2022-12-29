//
//  AddingQuestionViewController+Delegate.swift
//  Millionare
//
//  Created by Константин on 25.12.2022.
//

import UIKit

// MARK: - TableView Delegate

extension AddingQuestionViewController: UITableViewDelegate {}

// MARK: - AddingQuestionAnswerCell Delegate

extension AddingQuestionViewController: AddingQuestionAnswerCellDelegate {
    func send(answerType: AnswerType, fromCellWith answerNumber: Int) {
        switch answerType {
        case .correct:
            for row in 0 ..< numberAnswers {
                if row != (answerNumber - 1) {
                    guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? AddingQuestionAnswerCell else { return }
                    cell.setAnswerType(.incorrect)
                }
            }
        case .incorrect:
            guard let firstCell = tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? AddingQuestionAnswerCell else { return }
            firstCell.setAnswerType(.correct)
        }
    }
}

// MARK: - AddingQuestionFooterView Delegate

extension AddingQuestionViewController: AddingQuestionFooterViewDelegate {
    func addAnswer() {
        numberAnswers += 1
        tableView.insertRows(at: [IndexPath(row: (numberAnswers - 1), section: 0)], with: .automatic)
    }
}
