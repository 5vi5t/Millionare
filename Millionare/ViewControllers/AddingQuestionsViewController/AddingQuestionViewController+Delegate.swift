//
//  AddingQuestionsViewController+Delegate.swift
//  Millionare
//
//  Created by Константин on 25.12.2022.
//

import UIKit

// MARK: - TableView Delegate

extension AddingQuestionsViewController: UITableViewDelegate {}

// MARK: - AddingQuestionsFooterView Delegate

extension AddingQuestionsViewController: AddingQuestionsFooterViewDelegate {
    func addQuestion() {
        if checkQuestion() {
            numberQuestions += 1
            questionsBuilder.addQuestion()
            tableView.insertRows(at: [IndexPath(row: (numberQuestions - 1), section: 0)], with: .automatic)
            heightChanged()
        }
    }
}

extension AddingQuestionsViewController: AddingQuestionsCellDelegate {
    func heightChanged() {
        tableView.performBatchUpdates(nil)
    }
    
    func setQuestion(text: String, forQuestionNumber number: Int) {
        questionsBuilder.setQuestion(text: text, forQuestionNumber: number)
        emptyQuestions[(number - 1)] = text.isEmpty
    }
    
    func setAnswer(text: String, forAnswerNumber answerNumber: Int, atQuestionNumber questionNumber: Int) {
        questionsBuilder.setAnswer(text: text, forAnswerNumber: answerNumber, atQuestionNumber: questionNumber)
    }
    
    func setAnswer(type: AnswerType, forAnswerNumber answerNumber: Int, atQuestionNumber questionNumber: Int) {
        questionsBuilder.setAnswer(type: type, forAnswerNumber: answerNumber, atQuestionNumber: questionNumber)
        correctAnswers[(questionNumber - 1)] = type
    }
    
    func setEmptyAnswers(isEmpty: Bool, atQuestionNumber number: Int) {
        emptyAnswers[(number - 1)] = isEmpty
    }
    
}
