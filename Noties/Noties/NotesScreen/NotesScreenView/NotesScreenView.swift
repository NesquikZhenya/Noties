//
//  NotesScreenView.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

final class NotesScreenView: UIView {

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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        loadViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Configurating constraints

extension NotesScreenView: ViewSetuping {
    
    func loadViews(){
        [
            noNotesLabel,
            startNotesLabel
        ].forEach {self.addSubview($0)}
    }
    
    func setupConstraints() {
        configureNoNotesLabelConstraints()
        configureStartNotesLabelConstraints()
        
        [
            noNotesLabel,
            startNotesLabel
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureNoNotesLabelConstraints() {
        [
            noNotesLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 160),
            noNotesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ].forEach { $0.isActive = true }
    }
    
    private func configureStartNotesLabelConstraints() {
        [
            startNotesLabel.topAnchor.constraint(equalTo: noNotesLabel.bottomAnchor, constant: 8),
            startNotesLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ].forEach { $0.isActive = true }
    }
    
}

extension NotesScreenView {
    func configureView() {
        
    }
}
