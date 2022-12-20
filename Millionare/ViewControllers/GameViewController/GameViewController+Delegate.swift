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
        switch cell.correctAnswer {
        case .correct:
            indexQuestion += 1
            if indexQuestion < Question.questions.count {
                tableView.reloadData()
            } else {
                finishGame()
            }
        case .incorrect:
            finishGame()
        }
    }
    
    // MARK: - Functions
    
    func showAlertWith(questionNumber: Int, result: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "Всего \(questionNumber) вопросов, \(result) правильных ответов"
        let action = UIAlertAction(title: "Вернутся на главную", style: .default) { [weak self] _ in
            self?.dismiss(animated: true) {}
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func finishGame() {
        Game.shared.save()
        showAlertWith(questionNumber: questionNumber, result: result)
        delegate?.removeGameSession()
    }
}
