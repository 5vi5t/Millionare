//
//  QuestionsBuilder.swift
//  Millionare
//
//  Created by Константин on 04.01.2023.
//

import Foundation

protocol Builder {
    func addQuestion()
    func setQuestion(text: String, forQuestionNumber number: Int)
    func setAnswer(text: String, forAnswerNumber answerNumber: Int, atQuestionNumber questionNumber: Int)
    func setAnswer(type: AnswerType, forAnswerNumber answerNumber: Int, atQuestionNumber questionNumber: Int)
    func build() -> [Question]
}

class QuestionsBuilder: Builder {
    private var questions: [Question] = []
    
    func addQuestion() {
        let question = Question(text: "", answers: [])
        questions.append(question)
    }
    
    private func addAnswer(toQuestion question: Int) {
        questions[(question - 1)].answers.append(Answer(text: "", type: .incorrect))
    }
    
    func setQuestion(text: String, forQuestionNumber number: Int) {
        guard number <= questions.count,
              number > 0
        else { return }
        questions[(number - 1)].text = text
    }
    
    func setAnswer(text: String, forAnswerNumber answerNumber: Int, atQuestionNumber questionNumber: Int) {
        while answerNumber > questions[(questionNumber - 1)].answers.count {
            addAnswer(toQuestion: questionNumber)
        }
        guard questionNumber <= questions.count,
              questionNumber > 0,
              answerNumber <= questions[(questionNumber - 1)].answers.count,
              answerNumber > 0
        else { return }
        questions[(questionNumber - 1)].answers[(answerNumber - 1)].text = text
    }
    
    func setAnswer(type: AnswerType, forAnswerNumber answerNumber: Int, atQuestionNumber questionNumber: Int) {
        guard questionNumber <= questions.count,
              questionNumber > 0,
              answerNumber <= questions[(questionNumber - 1)].answers.count,
              answerNumber > 0
        else { return }
        questions[(questionNumber - 1)].answers[(answerNumber - 1)].type = type
    }
    
    func build() -> [Question] {
        return questions
    }
}
