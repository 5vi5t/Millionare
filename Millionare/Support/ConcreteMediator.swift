//
//  ConcreteMediator.swift
//  Millionare
//
//  Created by Константин on 22.12.2022.
//

import Foundation

protocol Colleague: AnyObject {
    func colleague(_ colleague: Colleague, didSendMessage message: String)
}

protocol Mediator: AnyObject {
    func addColleague(_ colleague: Colleague)
    func sendMessage(_ message: String, by colleague: Colleague)
}

class ConcreteMediator: Mediator {
    var colleagues: [Colleague] = []
    
    func addColleague(_ colleague: Colleague) {
        self.colleagues.append(colleague)
    }
    
    func sendMessage(_ message: String, by colleague: Colleague) {
        for colleagueToSend in self.colleagues where colleagueToSend !== colleague {
            colleagueToSend.colleague(colleague, didSendMessage: message)
        }
    }
}
