//
//  Question.swift
//  Millionare
//
//  Created by Константин on 24.11.2022.
//

import Foundation

enum CorrectAnswer {
    case correct
    case incorrect
}

struct Answer {
    let answer: String
    let isCorrect: CorrectAnswer
}

struct Question {
    let question: String
    let answers: [Answer]
}

extension Question {
    static let questions = [
        Question(question: "1. Допустим мы, используя AutoLayout, разместили 2 картинки на вью, дав им размеры 40х40 и поставили отступ между ними в 10, теперь первая картинка имеет отступ от верха равный 10, а вторая (находящаяся под первой), соответственно имеет отступ в 60 от верха. После этого, во время выполнения программы, мы изменили размеры первой картинки с 40х40 на 30х30. Что произойдет?",
                 answers: [
                    Answer(answer: "Ничего, размер картинки не изменится", isCorrect: .incorrect),
                    Answer(answer: "Первая картинка изменится, а вторая станет выше на 10", isCorrect: .correct),
                    Answer(answer: "Она уменьшится, но вторая не изменится ни в размере, ни в своём положении", isCorrect: .incorrect)
                 ]),
        Question(question: "2. Допустим, у нас есть задача загрузить картинку, затем изменить её размер, добавить элемент на картинку и после применить фильтр, а в конце отобразить пользователю. Какой тип очереди использовать для такой задачи?",
                 answers: [
                    Answer(answer: "Любую, кроме main queue", isCorrect: .correct),
                    Answer(answer: "Создать свою параллельную очередь", isCorrect: .incorrect),
                    Answer(answer: "Использовать системную background или default", isCorrect: .incorrect),
                    Answer(answer: "Создать свою последовательную очередь", isCorrect: .incorrect)
                 ]),
        Question(question: "3. Какая константа позволяет получить доступ к временным файлам?",
                 answers: [
                    Answer(answer: "NSTemporaryDirectory", isCorrect: .correct),
                    Answer(answer: "NSBundle", isCorrect: .incorrect)
                 ]),
        Question(question: "4. Можем ли мы указать свою цену для встроенной покупки произвольно?",
                 answers: [
                    Answer(answer: "Да", isCorrect: .incorrect),
                    Answer(answer: "Нет, только выбрать из списка, предоставленного Apple", isCorrect: .correct)
                 ]),
        Question(question: "5. Если мы объявляем переменную, указывающую на делегат, то какую использовать?",
                 answers: [
                    Answer(answer: "Только слабую", isCorrect: .correct),
                    Answer(answer: "Только сильную ссылку", isCorrect: .incorrect)
                 ]),
        Question(question: "6. Допустим, мы создали последовательную очередь из 8 задач, используя замыкания. Можем ли мы при необходимости отменить часть задач?",
                 answers: [
                    Answer(answer: "Нет, так как такой возможности у GCD очередей нет", isCorrect: .incorrect),
                    Answer(answer: "Да, но только те, которые еще не начались", isCorrect: .correct)
                 ]),
        Question(question: "7. Подходит ли главный поток для выполнения сложных вычислений?",
                 answers: [
                    Answer(answer: "Нет, нужно использовать фоновый метод", isCorrect: .correct),
                    Answer(answer: "Да", isCorrect: .incorrect)
                 ]),
        Question(question: "8. С каким каталогом может работать приложение?",
                 answers: [
                    Answer(answer: "Tmp и Documents", isCorrect: .incorrect),
                    Answer(answer: "Library", isCorrect: .incorrect),
                    Answer(answer: "Documents", isCorrect: .incorrect),
                    Answer(answer: "Library и tmp", isCorrect: .incorrect),
                    Answer(answer: "Tmp, Library и Documents", isCorrect: .correct),
                    Answer(answer: "Tmp", isCorrect: .incorrect)
                 ]),
        Question(question: "9. В каком случае можно использовать синглтон?",
                 answers: [
                    Answer(answer: "Для представления каких-либо классов, которые должны существовать в единственном экземпляре в контексте всей программы", isCorrect: .correct),
                    Answer(answer: "Для передачи между вью контроллерами", isCorrect: .incorrect),
                    Answer(answer: "Для хранения каких-либо общих данных, которые используются в разных объектах, например данные профиля пользователя", isCorrect: .incorrect)
                 ]),
        Question(question: "10. Допустим, у нас есть приложение с возможностью купить дополнительные уровни, которые остаются доступны пользователю всегда. Какой тип покупок мы можем использовать?",
                 answers: [
                    Answer(answer: "Consumable", isCorrect: .incorrect),
                    Answer(answer: "Любой", isCorrect: .incorrect),
                    Answer(answer: "Non-consumable", isCorrect: .correct),
                    Answer(answer: "Subscription", isCorrect: .incorrect)
                 ])
    ]
}
