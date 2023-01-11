//
//  GameViewController+HintsViewDelegate.swift
//  Millionare
//
//  Created by Константин on 19.12.2022.
//

import UIKit

extension GameViewController: HintsViewDelegate {
    func use(hint: Hint) {
        gameSession?.hintUsageFacade.currentQuestion = questions[indexQuestion]
        switch hint {
        case .callFriend:
            gameSession?.hintUsageFacade.callFriend()
        case .hallHelp:
            gameSession?.hintUsageFacade.useAuditoryHelp()
        case .fiftyFifty:
            gameSession?.hintUsageFacade.use50To50Hint()
        }
        if let question = gameSession?.hintUsageFacade.currentQuestion {
            questions[indexQuestion] = question
            tableView.reloadData()
        }
    }
}
