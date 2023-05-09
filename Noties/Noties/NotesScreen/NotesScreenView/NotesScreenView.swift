//
//  NotesScreenView.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

final class NotesScreenView: UIView {
    
    private let addNoteButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        button.setImage(UIImage(named: "plus"), for: .normal)
        button.layer.cornerRadius = 8
        return button
    }()

    private lazy var noNotesStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(noNotesLabel)
        stackView.addArrangedSubview(startNotesLabel)
        stackView.spacing = 8
        return stackView
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
    
    private let notesTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        loadViews()
        setupConstraints()
        notesTableView.dataSource = self
        notesTableView.delegate = self
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
            noNotesStackView
        ].forEach {self.addSubview($0)}
    }
    
    func setupConstraints() {
        configureAddNoteButtonConstraints()
        configureNoNotesStackViewConstraints()
        
        [
            addNoteButton,
            noNotesStackView
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureAddNoteButtonConstraints() {
        [
            addNoteButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 60),
            addNoteButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            addNoteButton.widthAnchor.constraint(equalToConstant: 40),
            addNoteButton.heightAnchor.constraint(equalToConstant: 40)
        ].forEach { $0.isActive = true }
    }
    
    private func configureNoNotesStackViewConstraints() {
        [
            noNotesStackView.topAnchor.constraint(equalTo: addNoteButton.bottomAnchor, constant: 40),
            noNotesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ].forEach { $0.isActive = true }
    }
    
}

extension NotesScreenView {
    func configureView() {
        
    }
}

extension NotesScreenView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
}
