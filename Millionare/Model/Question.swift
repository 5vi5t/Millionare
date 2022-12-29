//
//  Question.swift
//  Millionare
//
//  Created by Константин on 24.11.2022.
//

import Foundation

enum AnswerType: Int, CaseIterable, CustomStringConvertible, Codable {
    case correct
    case incorrect
    
    var description: String {
        switch self {
        case .correct:
            return "Правильный"
        case .incorrect:
            return "Неправильный"
        }
    }
    
    func toggle() -> Self {
        switch self {
        case .incorrect:
            return .correct
        case .correct:
            return .incorrect
        }
    }
}

enum Hints: CaseIterable, CustomStringConvertible {
    case callFriend, hallHelp, fiftyFifty
    
    var icon: String {
        switch self {
        case .callFriend: return "phone.and.waveform"
        case .hallHelp: return "person.3"
        case .fiftyFifty: return "eye"
        }
    }
    
    var description: String {
        switch self {
        case .callFriend:
            return "Звонок другу"
        case .hallHelp:
            return "Помощь зала"
        case .fiftyFifty:
            return "Пятьдесят на пятьдесят"
        }
    }
}

enum HintType: Codable {
    case right, wrong, none
}

struct Answer: Codable {
    let answer: String
    let correctAnswer: AnswerType
    var hint: HintType = .none
}

struct Question: Codable {
    let question: String
    var answers: [Answer]
    
    mutating func use(hint: Hints) {
        switch hint {
        case .callFriend:
            let successRate = Int.random(in: 1...10)
            let success = 1...9
            if success.contains(successRate) {
                for index in 0 ..< answers.count {
                    var modifiedAnswer = answers[index]
                    if modifiedAnswer.correctAnswer == .correct {
                        modifiedAnswer.hint = .right
                    } else {
                        modifiedAnswer.hint = .wrong
                    }
                    answers[index] = modifiedAnswer
                }
            } else {
                let fakeHint = Int.random(in: 0..<answers.count)
                for index in 0 ..< answers.count {
                    var modifiedAnswer = answers[index]
                    if index == fakeHint {
                        modifiedAnswer.hint = .right
                    } else {
                        modifiedAnswer.hint = .wrong
                    }
                    answers[index] = modifiedAnswer
                }
            }
        case .hallHelp:
            let successRate = Int.random(in: 1...10)
            let success = 1...6
            if success.contains(successRate) {
                for index in 0 ..< answers.count {
                    var modifiedAnswer = answers[index]
                    if modifiedAnswer.correctAnswer == .correct {
                        modifiedAnswer.hint = .right
                    } else {
                        modifiedAnswer.hint = .wrong
                    }
                    answers[index] = modifiedAnswer
                }
            } else {
                let fakeHint = Int.random(in: 0..<answers.count)
                for index in 0 ..< answers.count {
                    var modifiedAnswer = answers[index]
                    if index == fakeHint {
                        modifiedAnswer.hint = .right
                    } else {
                        modifiedAnswer.hint = .wrong
                    }
                    answers[index] = modifiedAnswer
                }
            }
        case .fiftyFifty:
                //TODO: - нужно добавить рандома
            let incorrectAnswersCount = answers.count / 2
            var counter = 0
            for index in 0 ..< answers.count {
                var modifiedAnswer = answers[index]
                if modifiedAnswer.correctAnswer == .incorrect && counter < incorrectAnswersCount {
                    modifiedAnswer.hint = .wrong
                    counter += 1
                }
                answers[index] = modifiedAnswer
            }
        }
    }
}

extension Question {
    static let questions = [
        Question(question: "1. Допустим мы, используя AutoLayout, разместили 2 картинки на вью, дав им размеры 40х40 и поставили отступ между ними в 10, теперь первая картинка имеет отступ от верха равный 10, а вторая (находящаяся под первой), соответственно имеет отступ в 60 от верха. После этого, во время выполнения программы, мы изменили размеры первой картинки с 40х40 на 30х30. Что произойдет?",
                 answers: [
                    Answer(answer: "Ничего, размер картинки не изменится", correctAnswer: .incorrect),
                    Answer(answer: "Первая картинка изменится, а вторая станет выше на 10", correctAnswer: .correct),
                    Answer(answer: "Она уменьшится, но вторая не изменится ни в размере, ни в своём положении", correctAnswer: .incorrect)
                 ]),
        Question(question: "2. Допустим, у нас есть задача загрузить картинку, затем изменить её размер, добавить элемент на картинку и после применить фильтр, а в конце отобразить пользователю. Какой тип очереди использовать для такой задачи?",
                 answers: [
                    Answer(answer: "Любую, кроме main queue", correctAnswer: .correct),
                    Answer(answer: "Создать свою параллельную очередь", correctAnswer: .incorrect),
                    Answer(answer: "Использовать системную background или default", correctAnswer: .incorrect),
                    Answer(answer: "Создать свою последовательную очередь", correctAnswer: .incorrect)
                 ]),
        Question(question: "3. Какая константа позволяет получить доступ к временным файлам?",
                 answers: [
                    Answer(answer: "NSTemporaryDirectory", correctAnswer: .correct),
                    Answer(answer: "NSBundle", correctAnswer: .incorrect)
                 ]),
        Question(question: "4. Можем ли мы указать свою цену для встроенной покупки произвольно?",
                 answers: [
                    Answer(answer: "Да", correctAnswer: .incorrect),
                    Answer(answer: "Нет, только выбрать из списка, предоставленного Apple", correctAnswer: .correct)
                 ]),
        Question(question: "5. Если мы объявляем переменную, указывающую на делегат, то какую использовать?",
                 answers: [
                    Answer(answer: "Только слабую", correctAnswer: .correct),
                    Answer(answer: "Только сильную ссылку", correctAnswer: .incorrect)
                 ]),
        Question(question: "6. Допустим, мы создали последовательную очередь из 8 задач, используя замыкания. Можем ли мы при необходимости отменить часть задач?",
                 answers: [
                    Answer(answer: "Нет, так как такой возможности у GCD очередей нет", correctAnswer: .incorrect),
                    Answer(answer: "Да, но только те, которые еще не начались", correctAnswer: .correct)
                 ]),
        Question(question: "7. Подходит ли главный поток для выполнения сложных вычислений?",
                 answers: [
                    Answer(answer: "Нет, нужно использовать фоновый метод", correctAnswer: .correct),
                    Answer(answer: "Да", correctAnswer: .incorrect)
                 ]),
        Question(question: "8. С каким каталогом может работать приложение?",
                 answers: [
                    Answer(answer: "Tmp и Documents", correctAnswer: .incorrect),
                    Answer(answer: "Library", correctAnswer: .incorrect),
                    Answer(answer: "Documents", correctAnswer: .incorrect),
                    Answer(answer: "Library и tmp", correctAnswer: .incorrect),
                    Answer(answer: "Tmp, Library и Documents", correctAnswer: .correct),
                    Answer(answer: "Tmp", correctAnswer: .incorrect)
                 ]),
        Question(question: "9. В каком случае можно использовать синглтон?",
                 answers: [
                    Answer(answer: "Для представления каких-либо классов, которые должны существовать в единственном экземпляре в контексте всей программы", correctAnswer: .correct),
                    Answer(answer: "Для передачи между вью контроллерами", correctAnswer: .incorrect),
                    Answer(answer: "Для хранения каких-либо общих данных, которые используются в разных объектах, например данные профиля пользователя", correctAnswer: .incorrect)
                 ]),
        Question(question: "10. Допустим, у нас есть приложение с возможностью купить дополнительные уровни, которые остаются доступны пользователю всегда. Какой тип покупок мы можем использовать?",
                 answers: [
                    Answer(answer: "Consumable", correctAnswer: .incorrect),
                    Answer(answer: "Любой", correctAnswer: .incorrect),
                    Answer(answer: "Non-consumable", correctAnswer: .correct),
                    Answer(answer: "Subscription", correctAnswer: .incorrect)
                 ])
    ]
}
