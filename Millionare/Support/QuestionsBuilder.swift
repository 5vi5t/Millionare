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

    /*
     5. * Задание на паттерн Builder. Экран добавления вопроса реализуйте в виде вью-контроллера с table view. Форма заполнения вопроса — это ячейка UITableView с текстовыми полями. Внизу table view добавьте кнопку в виде плюса, при нажатии на которую к table view добавится еще одна ячейка с формой ввода вопроса. Кнопка «Добавить» должна добавлять в приложение не один вопрос, а массив вопросов. Создание массива новых вопросов из введенных на экране данных реализуйте с помощью builder. Билдер при вызове функции build() должен вернуть именно массив вопросов. Сам билдер можно хранить и использовать прямо во время работы программы — когда юзер что-то ввел, у билдера вызвали соответствующий метод.
     
     Question(text: "1. Допустим мы, используя AutoLayout, разместили 2 картинки на вью, дав им размеры 40х40 и поставили отступ между ними в 10, теперь первая картинка имеет отступ от верха равный 10, а вторая (находящаяся под первой), соответственно имеет отступ в 60 от верха. После этого, во время выполнения программы, мы изменили размеры первой картинки с 40х40 на 30х30. Что произойдет?",
              answers: [
                 Answer(text: "Ничего, размер картинки не изменится", type: .incorrect),
                 Answer(answer: "Первая картинка изменится, а вторая станет выше на 10", correctAnswer: .correct),
                 Answer(answer: "Она уменьшится, но вторая не изменится ни в размере, ни в своём положении", correctAnswer: .incorrect)
              ]),
     
     struct Question: Codable {
         let question: String
         var answers: [Answer]
     
     struct Answer: Codable {
         let answer: String
         let correctAnswer: AnswerType
         var hint: HintType = .none
     */
