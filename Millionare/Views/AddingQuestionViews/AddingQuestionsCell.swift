//
//  AddingQuestionsCell.swift
//  Millionare
//
//  Created by Константин on 01.01.2023.
//

import UIKit

protocol AddingQuestionsCellDelegate: AnyObject {
    func heightChanged()
    func setQuestion(text: String, forQuestionNumber number: Int)
    func setAnswer(text: String, forAnswerNumber answerNumber: Int, atQuestionNumber questionNumber: Int)
    func setAnswer(type: AnswerType, forAnswerNumber answerNumber: Int, atQuestionNumber questionNumber: Int)
    func showAlertWith(title: String?, message: String?)
    func setEmptyAnswers(isEmpty: Bool, atQuestionNumber number: Int)
}

class AddingQuestionsCell: UITableViewCell {
    
    // MARK: - Static properties
    
    static let identifier = String(describing: AddingQuestionsCell.self)
    
    // MARK: - Properties
    
    var numberAnswers = 0
    weak var delegate: AddingQuestionsCellDelegate?
    var emptyAnswers: [Int: Bool] = [:] {
        didSet {
            delegate?.setEmptyAnswers(isEmpty: emptyAnswers.contains(where: { $1 }), atQuestionNumber: questionNumber)
        }
    }
    
    // MARK: - Private properties
    
    private(set) lazy var tableView: UITableView = {
        let tableView = NestedTableView(frame: .zero, style: .grouped)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.backgroundColor = .white
        tableView.isScrollEnabled = false
        tableView.register(AddingQuestionsAnswerCell.self, forCellReuseIdentifier: AddingQuestionsAnswerCell.identifier)
        tableView.register(AddingQuestionsAnswerHeaderView.self, forHeaderFooterViewReuseIdentifier: AddingQuestionsAnswerHeaderView.identifier)
        tableView.register(AddingQuestionsAnswerFooterView.self, forHeaderFooterViewReuseIdentifier: AddingQuestionsAnswerFooterView.identifier)
        return tableView
    }()
    private(set) var questionNumber = 0
    
    // MARK: - Construction
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Functions
    
    func set(numberQuestion: Int) {
        self.questionNumber = numberQuestion
    }
    
    // MARK: - Private functions
    
    private func setupView() {
        numberAnswers = 2
        selectionStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: contentView.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ])
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        numberAnswers = 2
        tableView.reloadData()
    }
}

// MARK: - UITableView Data Source

extension AddingQuestionsCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        numberAnswers
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AddingQuestionsAnswerCell.identifier, for: indexPath) as? AddingQuestionsAnswerCell else { return UITableViewCell() }
        cell.setAnswerNumber(indexPath.row + 1)
        cell.delegate = self
        emptyAnswers[indexPath.row] = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddingQuestionsAnswerHeaderView.identifier) as? AddingQuestionsAnswerHeaderView else { return nil }
        header.set(numberQuestion: questionNumber)
        header.delegate = self
        return header
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        guard let footer = tableView.dequeueReusableHeaderFooterView(withIdentifier: AddingQuestionsAnswerFooterView.identifier) as? AddingQuestionsAnswerFooterView else { return nil }
        footer.delegate = self
        return footer
    }
}

// MARK: - UITableView Delegate

extension AddingQuestionsCell: UITableViewDelegate {}

// MARK: - AddingQuestionsAnswerHeaderView Delegate

extension AddingQuestionsCell: AddingQuestionsAnswerHeaderViewDelegate {
    func setQuestion(text: String) {
        delegate?.setQuestion(text: text, forQuestionNumber: questionNumber)
    }
}

// MARK: - AddingQuestionsAnswerCell Delegate

extension AddingQuestionsCell: AddingQuestionsAnswerCellDelegate {
    func setAnswer(type: AnswerType, forAnswerNumber number: Int) {
        switch type {
        case .correct:
            for row in 0 ..< numberAnswers {
                if row != (number - 1) {
                    guard let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? AddingQuestionsAnswerCell else { return }
                    if cell.answerType == .correct {
                        cell.setAnswerType(.incorrect)
                    }
                }
            }
        case .incorrect:
            break
        }
        delegate?.setAnswer(type: type, forAnswerNumber: number, atQuestionNumber: questionNumber)
    }
    
    func setAnswer(text: String, forAnswerNumber number: Int) {
        delegate?.setAnswer(text: text, forAnswerNumber: number, atQuestionNumber: questionNumber)
        emptyAnswers[(number - 1)] = text.isEmpty
    }
}

// MARK: - AddingQuestionsAnswerFooterView Delegate

extension AddingQuestionsCell: AddingQuestionsAnswerFooterViewDelegate {
    func addAnswer() {
        if emptyAnswers.contains(where: { $1 }) {
            delegate?.showAlertWith(title: "Ответы не заполнены!", message: nil)
        } else {
            numberAnswers += 1
            tableView.insertRows(at: [IndexPath(row: (numberAnswers - 1), section: 0)], with: .automatic)
            delegate?.heightChanged()
        }
    }
}
