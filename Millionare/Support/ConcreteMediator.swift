//
//  ConcreteMediator.swift
//  Millionare
//
//  Created by Константин on 22.12.2022.
//

import Foundation

protocol Colleague: AnyObject {
    var id: UUID { get }
    func colleague(_ colleague: Colleague, didSendMessage message: AnswerType)
}

protocol Mediator: AnyObject {
    func addColleague(_ colleague: Colleague)
    func sendMessage(_ message: AnswerType, by colleague: Colleague)
}

class ConcreteMediator: Mediator {
    var colleagues: [Colleague] = []
    
    func addColleague(_ colleague: Colleague) {
        if !colleagues.contains(where: { $0.id == colleague.id }) {
            self.colleagues.append(colleague)
        }
    }
    
    func sendMessage(_ message: AnswerType, by colleague: Colleague) {
        for colleagueToSend in self.colleagues where colleagueToSend !== colleague {
            colleagueToSend.colleague(colleague, didSendMessage: message)
        }
    }
}
