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
        if cell.correctAnswer {
            indexQuestion += 1
            if indexQuestion < Question.questions.count {
                tableView.reloadData()
            } else {
                finishGame()
            }
        } else {
            finishGame()
        }
    }
    
    // MARK: - Functions
    
    func showAlertWith(result: String) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = "Отвечено на \(result) вопросов"
        let action = UIAlertAction(title: "Вернутся на главную", style: .default) { [weak self] _ in
            self?.dismiss(animated: true) {}
        }
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func finishGame() {
        delegate?.save(result: indexQuestion)
        Game.shared.save()
        showAlertWith(result: Game.shared.result)
        delegate?.removeGameSession()
    }
}
