//
//  MainMenuViewController.swift
//  Millionare
//
//  Created by Константин on 22.11.2022.
//

import UIKit

class MainMenuViewController: UIViewController {

    // MARK: - Properties
    
    var gameSession: GameSession? {
        didSet {
            Game.shared.gameSession = gameSession
        }
    }
    
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
    private lazy var settingsButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "wrench.and.screwdriver"), for: .normal)
        button.tintColor = .black
        button.addTarget(self,
                         action: #selector(settingsButtonTap),
                         for: .touchUpInside)
        return button
    }()
    private lazy var addQuestionButton: UIButton = {
        let button = UIButton()
        button.setTitle("Добавить вопрос", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self,
                         action: #selector(addQuestionButtonTap),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupView()
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.backgroundColor = .white
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate([
            stackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        
        [playButton, resultButton, addQuestionButton].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            stackView.addArrangedSubview($0)
        }
        
        view.addSubview(settingsButton)
        settingsButton.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            settingsButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 20),
            settingsButton.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            settingsButton.heightAnchor.constraint(equalToConstant: 50),
            settingsButton.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc private func playButtonTap() {
        let gameVC = GameViewController()
        gameSession = GameSession()
        gameVC.delegate = self
        gameVC.gameSession = gameSession
        gameVC.modalPresentationStyle = .fullScreen
        self.present(gameVC, animated: true)
    }
    
    @objc private func resultButtonTap() {
        let resultVC = ResultViewController()
        self.present(resultVC, animated: true)
    }
    
    @objc private func settingsButtonTap() {
        let settingsVC = SettingsViewController()
        self.present(settingsVC, animated: true)
    }
    
    @objc private func addQuestionButtonTap() {
        let addingQuestionsVC = AddingQuestionsViewController()
        self.present(addingQuestionsVC, animated: true)
    }
}
