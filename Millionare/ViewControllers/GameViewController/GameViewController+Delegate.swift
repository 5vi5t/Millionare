//
//  GameViewController+Delegate.swift
//  Millionare
//
//  Created by Константин on 24.11.2022.
//

import UIKit

extension GameViewController: UITableViewDelegate {
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? AnswerCell else { return }
        if cell.correctAnswer,
           indexQuestion < Question.questions.count - 1 {
            indexQuestion += 1
            tableView.reloadData()
        } else {
            delegate?.save(result: indexQuestion)
            Game.shared.save()
            showResult(result: indexQuestion)
        }
    }
    
    // MARK: - Functions
    
    func showResult(result: Int) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "Отвечено на \(result) вопросов"
        let action = UIAlertAction(title: "Вернутся на главную", style: .default) { [weak self] _ in
            self?.dismiss(animated: true) {}
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
}
