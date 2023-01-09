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

enum Hint: CaseIterable, CustomStringConvertible {
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
    var text: String
    var type: AnswerType
    var hintType: HintType = .none
}

struct Question: Codable {
    var text: String
    var answers: [Answer]
    
    mutating func use(hint: Hint) {
        switch hint {
        case .callFriend:
            let successRate = Int.random(in: 1...10)
            let success = 1...9
            if success.contains(successRate) {
                for index in 0 ..< answers.count {
                    var modifiedAnswer = answers[index]
                    if modifiedAnswer.type == .correct {
                        modifiedAnswer.hintType = .right
                    } else {
                        modifiedAnswer.hintType = .wrong
                    }
                    answers[index] = modifiedAnswer
                }
            } else {
                let fakeHint = Int.random(in: 0..<answers.count)
                for index in 0 ..< answers.count {
                    var modifiedAnswer = answers[index]
                    if index == fakeHint {
                        modifiedAnswer.hintType = .right
                    } else {
                        modifiedAnswer.hintType = .wrong
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
                    if modifiedAnswer.type == .correct {
                        modifiedAnswer.hintType = .right
                    } else {
                        modifiedAnswer.hintType = .wrong
                    }
                    answers[index] = modifiedAnswer
                }
            } else {
                let fakeHint = Int.random(in: 0..<answers.count)
                for index in 0 ..< answers.count {
                    var modifiedAnswer = answers[index]
                    if index == fakeHint {
                        modifiedAnswer.hintType = .right
                    } else {
                        modifiedAnswer.hintType = .wrong
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
                if modifiedAnswer.type == .incorrect && counter < incorrectAnswersCount {
                    modifiedAnswer.hintType = .wrong
                    counter += 1
                }
                answers[index] = modifiedAnswer
            }
        }
    }
}

extension Question {
    static let questions = [
        Question(text: "1. Допустим мы, используя AutoLayout, разместили 2 картинки на вью, дав им размеры 40х40 и поставили отступ между ними в 10, теперь первая картинка имеет отступ от верха равный 10, а вторая (находящаяся под первой), соответственно имеет отступ в 60 от верха. После этого, во время выполнения программы, мы изменили размеры первой картинки с 40х40 на 30х30. Что произойдет?",
                 answers: [
                    Answer(text: "Ничего, размер картинки не изменится", type: .incorrect),
                    Answer(text: "Первая картинка изменится, а вторая станет выше на 10", type: .correct),
                    Answer(text: "Она уменьшится, но вторая не изменится ни в размере, ни в своём положении", type: .incorrect)
                 ]),
        Question(text: "2. Допустим, у нас есть задача загрузить картинку, затем изменить её размер, добавить элемент на картинку и после применить фильтр, а в конце отобразить пользователю. Какой тип очереди использовать для такой задачи?",
                 answers: [
                    Answer(text: "Любую, кроме main queue", type: .correct),
                    Answer(text: "Создать свою параллельную очередь", type: .incorrect),
                    Answer(text: "Использовать системную background или default", type: .incorrect),
                    Answer(text: "Создать свою последовательную очередь", type: .incorrect)
                 ]),
        Question(text: "3. Какая константа позволяет получить доступ к временным файлам?",
                 answers: [
                    Answer(text: "NSTemporaryDirectory", type: .correct),
                    Answer(text: "NSBundle", type: .incorrect)
                 ]),
        Question(text: "4. Можем ли мы указать свою цену для встроенной покупки произвольно?",
                 answers: [
                    Answer(text: "Да", type: .incorrect),
                    Answer(text: "Нет, только выбрать из списка, предоставленного Apple", type: .correct)
                 ]),
        Question(text: "5. Если мы объявляем переменную, указывающую на делегат, то какую использовать?",
                 answers: [
                    Answer(text: "Только слабую", type: .correct),
                    Answer(text: "Только сильную ссылку", type: .incorrect)
                 ]),
        Question(text: "6. Допустим, мы создали последовательную очередь из 8 задач, используя замыкания. Можем ли мы при необходимости отменить часть задач?",
                 answers: [
                    Answer(text: "Нет, так как такой возможности у GCD очередей нет", type: .incorrect),
                    Answer(text: "Да, но только те, которые еще не начались", type: .correct)
                 ]),
        Question(text: "7. Подходит ли главный поток для выполнения сложных вычислений?",
                 answers: [
                    Answer(text: "Нет, нужно использовать фоновый метод", type: .correct),
                    Answer(text: "Да", type: .incorrect)
                 ]),
        Question(text: "8. С каким каталогом может работать приложение?",
                 answers: [
                    Answer(text: "Tmp и Documents", type: .incorrect),
                    Answer(text: "Library", type: .incorrect),
                    Answer(text: "Documents", type: .incorrect),
                    Answer(text: "Library и tmp", type: .incorrect),
                    Answer(text: "Tmp, Library и Documents", type: .correct),
                    Answer(text: "Tmp", type: .incorrect)
                 ]),
        Question(text: "9. В каком случае можно использовать синглтон?",
                 answers: [
                    Answer(text: "Для представления каких-либо классов, которые должны существовать в единственном экземпляре в контексте всей программы", type: .correct),
                    Answer(text: "Для передачи между вью контроллерами", type: .incorrect),
                    Answer(text: "Для хранения каких-либо общих данных, которые используются в разных объектах, например данные профиля пользователя", type: .incorrect)
                 ]),
        Question(text: "10. Допустим, у нас есть приложение с возможностью купить дополнительные уровни, которые остаются доступны пользователю всегда. Какой тип покупок мы можем использовать?",
                 answers: [
                    Answer(text: "Consumable", type: .incorrect),
                    Answer(text: "Любой", type: .incorrect),
                    Answer(text: "Non-consumable", type: .correct),
                    Answer(text: "Subscription", type: .incorrect)
                 ])
    ]
}
