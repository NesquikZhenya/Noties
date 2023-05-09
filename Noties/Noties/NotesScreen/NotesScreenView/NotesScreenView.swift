//
//  NotesScreenView.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

final class NotesScreenView: UIView {
    
    private var notes: [Note] = []
    
    private let addNoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    private let noNotesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20, weight: .medium)
        label.text = "You don't have any notes yet"
        return label
    }()
    
    private let startNotesLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = .darkGray
        label.text = "Start using Noties by taping plus button"
        return label
    }()
    
    private lazy var noNotesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(noNotesLabel)
        stackView.addArrangedSubview(startNotesLabel)
        stackView.spacing = 8
        stackView.isHidden = true
        return stackView
    }()
    
    private let notesTableView: UITableView = {
        let tableView = UITableView(frame: CGRect(), style: .plain)
        tableView.showsVerticalScrollIndicator = false
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        return tableView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        loadViews()
        setupConstraints()
        notesTableView.dataSource = self
        notesTableView.delegate = self
        notesTableView.register(NotesTableViewCell.self, forCellReuseIdentifier: "NotesTableViewCell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Configurating constraints

extension NotesScreenView: ViewSetuping {
    
    func loadViews(){
        [
            addNoteButton,
            noNotesStackView,
            notesTableView
        ].forEach {self.addSubview($0)}
    }
    
    func setupConstraints() {
        configureAddNoteButtonConstraints()
        configureNoNotesStackViewConstraints()
        configureNotesTableViewConstraints()
        
        [
            addNoteButton,
            noNotesStackView,
            notesTableView
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureAddNoteButtonConstraints() {
        [
            addNoteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            addNoteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            addNoteButton.widthAnchor.constraint(equalToConstant: 40),
            addNoteButton.heightAnchor.constraint(equalToConstant: 40)
        ].forEach { $0.isActive = true }
    }
    
    private func configureNoNotesStackViewConstraints() {
        [
            noNotesStackView.topAnchor.constraint(equalTo: addNoteButton.bottomAnchor, constant: 20),
            noNotesStackView.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ].forEach { $0.isActive = true }
    }
    
    private func configureNotesTableViewConstraints() {
        [
            notesTableView.topAnchor.constraint(equalTo: addNoteButton.bottomAnchor, constant: 20),
            notesTableView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            notesTableView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            notesTableView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
    
}

//MARK: Configurating view

extension NotesScreenView {
    func configureView(notes: [Note]) {
        if notes.isEmpty {
            notesTableView.isHidden = true
            noNotesStackView.isHidden = false
        } else {
            self.notes = notes
            notesTableView.reloadData()
        }
    }
}

//MARK: Configurating NotesTableView

extension NotesScreenView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "NotesTableViewCell") as? NotesTableViewCell {
            cell.configureCell(note: notes[indexPath.row])
            return cell
        } else {
            return UITableViewCell()
        }
    }
    
}
