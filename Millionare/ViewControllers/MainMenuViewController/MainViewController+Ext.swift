//
//  MainViewController+Ext.swift
//  Millionare
//
//  Created by Константин on 02.12.2022.
//

import UIKit

// MARK: - GameViewControllerDelegate

extension MainMenuViewController: GameViewControllerDelegate {
    func send(totalQuestions number: Int) {
        gameSession?.totalQuestions = number
    }
    
    func send(questionNumber number: Int) {
        gameSession?.questionNumber = number
    }
    
    func send(correctAnswers number: Int) {
        gameSession?.correctAnswers = number
    }
    
    func removeGameSession() {
        gameSession = nil
    }
}
