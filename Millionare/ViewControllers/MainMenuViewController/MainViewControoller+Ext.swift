//
//  MainViewControoller+Ext.swift
//  Millionare
//
//  Created by Константин on 02.12.2022.
//

import UIKit

// MARK: - GameViewControllerDelegate

extension MainMenuViewController: GameViewControllerDelegate {
    func removeGameSession() {
        gameSession = nil
    }
    
    func save(result: Int) {
        gameSession?.correctAnswers = result
    }
}
