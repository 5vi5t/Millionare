//
//  GameViewController+HintsViewDelegate.swift
//  Millionare
//
//  Created by Константин on 19.12.2022.
//

import UIKit

extension GameViewController: HintsViewDelegate {
    func use(hint: Hints) {
        var question = questions[indexQuestion]
        question.use(hint: hint)
        questions[indexQuestion] = question
        tableView.reloadData()
    }
}
