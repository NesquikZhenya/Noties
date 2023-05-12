//
//  NotesTableViewCell.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit
import MapKit

protocol NotesTableViewCellListening: AnyObject {
    func mapNoteViewDidTap(note: Note?)
}

final class NotesTableViewCell: UITableViewCell {
    
    weak var delegate: NotesTableViewCellListening?
    private var note: Note? = nil
    
    private let backgroundTintView: UIView = {
        let view = UIView()
        view.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0, blue: 0.2078431373, alpha: 0.1)
        view.layer.cornerRadius = 10
        return view
    }()
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "attach")
        imageView.backgroundColor = #colorLiteral(red: 0.003921568627, green: 0, blue: 0.2078431373, alpha: 0.2)
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        imageView.tintColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.text = "Your first note"
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.numberOfLines = 2
        label.text = "Blah blah blah describing a lot of text and dsklfdklgjdkflgjdfklgjdlfkgjdfkgjdflkgjdfklgjdfklgjdfklgjdkfljgkldfjgkldfjglkdfjgkldfjglkdfjglkdfjglkdfjgkldfjg"
        return label
    }()

    private lazy var labelsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.spacing = 4
        return stackView
    }()
    
    private lazy var mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map")
        imageView.tintColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        imageView.isUserInteractionEnabled = true
        imageView.isHidden = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(mapNoteViewDidTap))
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        loadViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Configurating constraints

extension NotesTableViewCell: ViewSetuping {
    
    func loadViews(){
        [
            backgroundTintView,
            photoImageView,
            labelsStackView,
            mapImageView
        ].forEach {self.contentView.addSubview($0)}
    }
    
    func setupConstraints() {
        configureBackgroundViewConstraints()
        configurePhotoImageViewConstraints()
        configureLabelsStackViewConstraints()
        configureMapImageViewConstraints()
        
        [
            backgroundTintView,
            photoImageView,
            labelsStackView,
            mapImageView
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureBackgroundViewConstraints() {
        [
            backgroundTintView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 4),
            backgroundTintView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 8),
            backgroundTintView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -8),
            backgroundTintView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -4)
        ].forEach { $0.isActive = true }
    }
    
    private func configurePhotoImageViewConstraints() {
        [
            photoImageView.topAnchor.constraint(equalTo: backgroundTintView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: backgroundTintView.leadingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: backgroundTintView.bottomAnchor),
            photoImageView.widthAnchor.constraint(equalToConstant: 60),
            photoImageView.heightAnchor.constraint(equalToConstant: 60)
        ].forEach { $0.isActive = true }
    }
    
    
    private func configureLabelsStackViewConstraints() {
        [
            labelsStackView.topAnchor.constraint(equalTo: self.contentView.topAnchor, constant: 8),
            labelsStackView.leadingAnchor.constraint(equalTo: photoImageView.trailingAnchor, constant: 8),
            labelsStackView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor, constant: -8)
        ].forEach { $0.isActive = true }
    }
    
    private func configureMapImageViewConstraints() {
        [
            mapImageView.leadingAnchor.constraint(greaterThanOrEqualTo: labelsStackView.trailingAnchor, constant: 8),
            mapImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -24),
            mapImageView.centerYAnchor.constraint(equalTo: photoImageView.centerYAnchor)
        ].forEach { $0.isActive = true }
    }
    
}

//MARK: Configurating Cell

extension NotesTableViewCell {
    
    func configureCell(note: Note) {
        self.note = note
        photoImageView.image = note.picture
        titleLabel.text = note.title
        descriptionLabel.text = note.text
        if note.location.description != CLLocationCoordinate2D().description {
            mapImageView.isHidden = false
        } else {
            mapImageView.isHidden = true
        }
            
    }

}

//MARK: Configurating Interaction

extension NotesTableViewCell {
    
    @objc private func mapNoteViewDidTap() {
        self.delegate?.mapNoteViewDidTap(note: self.note)
    }
    
}

