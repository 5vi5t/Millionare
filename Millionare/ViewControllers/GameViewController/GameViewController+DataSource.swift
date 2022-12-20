//
//  GameViewController+DataSource.swift
//  Millionare
//
//  Created by Константин on 23.11.2022.
//

import UIKit

extension GameViewController: UITableViewDataSource {
    
    // MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions[indexQuestion].answers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AnswerCell.identifier, for: indexPath) as? AnswerCell else { return UITableViewCell() }
        let answer = questions[indexQuestion].answers[indexPath.row]
        cell.configure(answerLabelText: answer.answer, correctAnswer: answer.correctAnswer, hint: answer.hint)
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: QuestionView.identifier) as? QuestionView else { return nil }
        header.setQuestionLabel(text: questions[indexQuestion].question)
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: HintsView.identifier) as? HintsView else { return nil }
        let text = "Текущий вопрос \(questionNumber), процент ответов \(result)"
        footer.configure(hintsLabelText: text)
        footer.delegate = self
        return footer
    }
}
