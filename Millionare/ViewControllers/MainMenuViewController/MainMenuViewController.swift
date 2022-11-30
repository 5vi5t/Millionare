//
//  MainMenuViewController.swift
//  Millionare
//
//  Created by Константин on 22.11.2022.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - Properties
    
    var gameSession: GameSession?
    
    // MARK: - Private properties
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.backgroundColor = .white
        stack.spacing = 10
        return stack
    }()
    private lazy var playButton: UIButton = {
        let button = UIButton()
        button.setTitle("Играть", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self,
                         action: #selector(playButtonTap),
                         for: .touchUpInside)
        return button
    }()
    private lazy var resultButton: UIButton = {
        let button = UIButton()
        button.setTitle("Результаты", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self,
                         action: #selector(resultButtonTap),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }

    // MARK: - Functions
    
    
    // MARK: - Private functions
    
    private func setupView() {
        view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        [playButton, resultButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
    }
    
    @objc private func playButtonTap() {
        let gameVC = GameViewController()
        gameSession = GameSession()
        Game.shared.gameSession = gameSession
        gameVC.delegate = self
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true)
    }
    
    @objc private func resultButtonTap() {
        let resultVC = ResultViewController()
        self.present(resultVC, animated: true)
    }
}

    // MARK: - GameViewControllerDelegate

extension MainMenuViewController: GameViewControllerDelegate {
    func save(result: Int) {
        gameSession?.correctAnswers = result
    }
}

