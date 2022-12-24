//
//  AddingQuestionViewController.swift
//  Millionare
//
//  Created by Константин on 20.12.2022.
//

import UIKit

class AddingQuestionViewController: UIViewController {
    
    // MARK: - Properties
    
    var numberAnswers = 2
    let mediator = ConcreteMediator()
    
    // MARK: - Private properties
    
    private(set) lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.register(AddingQuestionAnswerCell.self, forCellReuseIdentifier: AddingQuestionAnswerCell.identifier)
        tableView.register(AddingQuestionHeaderView.self, forHeaderFooterViewReuseIdentifier: AddingQuestionHeaderView.identifier)
        tableView.register(AddingQuestionFooterView.self, forHeaderFooterViewReuseIdentifier: AddingQuestionFooterView.identifier)
        tableView.tableHeaderView = headerView
        tableView.tableFooterView = footerView
        return tableView
    }()
    private lazy var headerView: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.text = "Добавить вопрос"
        return label
    }()
    private lazy var footerView: UIButton = {
        let button = UIButton(type: .custom)
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
    
    // MARK: - Private functions
    
    private func setupView() {
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
    }
    
    @objc private func hideKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func addQuestionButtonTap() {
        /*
         1. из хедера получить вопрос done
         2. из ячеек получить ответы done
         3. проверить наличие вопроса и ответов done
         4. создать структуру из полученных данных done
         5. показать юзеру предупреждение в случае отсутствия данных
         */
        guard let question = (tableView.headerView(forSection: 0) as? AddingQuestionHeaderView)?.question,
              !question.isEmpty else {
            showAlertWith(title: "Нет вопроса!", message: nil)
            return
        }
        var answers: [Answer] = []
        var isAllowedAddQuestion = false
        for row in 0 ..< numberAnswers {
            if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? AddingQuestionAnswerCell,
               !cell.answer.isEmpty {
                let answer = Answer(answer: cell.answer, correctAnswer: cell.answerType)
                answers.append(answer)
                isAllowedAddQuestion = true
            } else {
                showAlertWith(title: "Нет ответа \(row + 1)!", message: nil)
                isAllowedAddQuestion = false
                break
            }
        }
        if isAllowedAddQuestion {
            let newQuestion = Question(question: question, answers: answers)
            Game.shared.save(question: newQuestion)
            dismiss(animated: true)
        }
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let kbSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        tableView.contentInset.bottom = kbSize.height
    }
    
    @objc private func keyboardWillHide() {
        tableView.contentInset = .zero
    }
    
    func showAlertWith(title: String?, message: String?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.title = title
        let action = UIAlertAction(title: "OK", style: .default)
        alert.addAction(action)
        present(alert, animated: true)
    }
}

// MARK: - AddingQuestionFooterView Delegate

extension AddingQuestionViewController: AddingQuestionFooterViewDelegate {
    func addAnswer() {
        numberAnswers += 1
        tableView.insertRows(at: [IndexPath(row: (numberAnswers - 1), section: 0)], with: .automatic)
    }
}
