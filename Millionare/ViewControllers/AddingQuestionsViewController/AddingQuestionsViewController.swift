//
//  AddingQuestionsViewController.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

class AddingQuestionsViewController: UIViewController {
    
    // MARK: - Properties
    
    var numberQuestions = 0
    let questionsBuilder = QuestionsBuilder()
    var emptyQuestions: [Int: Bool] = [:]
    var emptyAnswers: [Int: Bool] = [:]
    var correctAnswers: [Int: AnswerType] = [:]
    
    // MARK: - Private properties
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(AddingQuestionsCell.self, forCellReuseIdentifier: AddingQuestionsCell.identifier)
        tableView.register(AddingQuestionsFooterView.self, forHeaderFooterViewReuseIdentifier: AddingQuestionsFooterView.identifier)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        return tableView
    }()
    private lazy var headerView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Добавить вопросы"
        return label
    }()
    private lazy var footerView: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("Добавить вопросы", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .white
        button.addTarget(self,
                         action: #selector(addQuestionsButtonTap),
                         for: .touchUpInside)
        return button
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.sizeHeaderToFit(insets: 30)
        tableView.sizeFooterToFit()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardDidShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    // MARK: - Functions
    
    func showAlertWith(title: String?, message: String?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = title
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
    
    func checkQuestion() -> Bool {
        if emptyQuestions.contains(where: { $1 }) {
            showAlertWith(title: "Вопрос не заполнен!", message: nil)
            return false
        } else if emptyAnswers.contains(where: { $1 }) {
            showAlertWith(title: "Ответы не заполнены!", message: nil)
            return false
        } else if !correctAnswers.contains(where: { $1 == .correct }) {
            showAlertWith(title: "Не выбран правильный ответ!", message: nil)
            return false
        } else {
            return true
        }
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        numberQuestions = 1
        questionsBuilder.addQuestion()
        view.backgroundColor = .white
        let tap = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(tap)
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        heightChanged()
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func addQuestionsButtonTap() {
        if checkQuestion() {
            Game.shared.save(questions: questionsBuilder.build())
            self.dismiss(animated: true)
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        tableView.contentInset.bottom = kbSize.height
    }
    
    @objc private func keyboardWillHide() {
        tableView.contentInset = .zero
    }
}
