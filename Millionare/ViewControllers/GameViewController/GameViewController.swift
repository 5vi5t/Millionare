//
//  GameViewController.swift
//  Millionare
//
//  Created by Константин on 23.11.2022.
//

import UIKit

protocol GameViewControllerDelegate: AnyObject {
    func removeGameSession()
    func send(totalQuestions number: Int)
    func send(questionNumber number: Int)
    func send(correctAnswers number: Int)
}

class GameViewController: UIViewController {
    
    // MARK: - Properties
    
    var indexQuestion = 0 {
        didSet {
            delegate?.send(questionNumber: indexQuestion + 1)
            delegate?.send(correctAnswers: indexQuestion)
        }
    }
    var questions: [Question] = [] {
        didSet {
            delegate?.send(totalQuestions: questions.count)
        }
    }
    weak var delegate: GameViewControllerDelegate?
    var gameSession: GameSession?
    var questionNumber = 1
    var correctAnswers = 0
    var totalQuestions = 0
    var result: String {
        guard totalQuestions != 0 else { return "0 %"}
        return "\(correctAnswers * 100 / totalQuestions) %"
    }
    
    // MARK: - Private properties
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(AnswerCell.self, forCellReuseIdentifier: AnswerCell.identifier)
        tableView.register(QuestionView.self, forHeaderFooterViewReuseIdentifier: QuestionView.identifier)
        tableView.register(HintsView.self, forHeaderFooterViewReuseIdentifier: HintsView.identifier)
        tableView.tableHeaderView = headerView
        return tableView
    }()
    private lazy var headerView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Кто хочет стать iOS - разработчиком)"
        return label
    }()
    
    private lazy var orderQuestionsStrategy: OrderQuestionsStrategy = {
        switch Game.shared.orderQuestions {
        case .serial:
            return SerialOrderQuestionsStrategy()
        case .random:
            return RandomOrderQuestionsStrategy()
        }
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameSession?.questionNumber.addObserver(self, closure: { [weak self] (questionNumber, _) in
            self?.questionNumber = questionNumber
        })
        gameSession?.correctAnswers.addObserver(self, closure: { [weak self] (correctAnswers, _) in
            self?.correctAnswers = correctAnswers
        })
        gameSession?.totalQuestions.addObserver(self, closure: { [weak self] (totalQuestions, _) in            self?.totalQuestions = totalQuestions
        })
        questions = orderQuestionsStrategy.setOrder(questions: Question.questions)
        setupView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.sizeHeaderToFit(insets: 30)
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
}
