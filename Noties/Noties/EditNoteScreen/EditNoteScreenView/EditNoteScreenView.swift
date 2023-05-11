//
//  EditNoteScreenView.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit
import PhotosUI

final class EditNoteScreenView: UIView {
    
    weak var delegate: EditNoteScreenViewListening?
    var note = Note(id: UUID(),
                    title: "No name",
                    text: "Enter the note",
                    picture: UIImage(named: "attach")!,
                    location: "",
                    date: Date())
    
    private lazy var photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .gray
        imageView.image = UIImage(named: "attach")
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(photoImageViewDidTap))
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 24, weight: .semibold)
        textField.placeholder = "Enter the title"
        textField.delegate = self
        return textField
    }()
    
    private lazy var mapImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "map")
        imageView.tintColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        imageView.isUserInteractionEnabled = true
        let gesture = UITapGestureRecognizer(target: self, action: #selector(mapImageViewDidTap))
        imageView.addGestureRecognizer(gesture)
        return imageView
    }()
    
    lazy var descriptionTextView: UITextView = {
        let textView = UITextView()
        textView.font = .systemFont(ofSize: 20, weight: .regular)
        textView.text = "Enter the note"
        textView.delegate = self
        return textView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        loadViews()
        setupConstraints()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        self.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Configurating constraints

extension EditNoteScreenView: ViewSetuping {
    
    func loadViews(){
        [
            photoImageView,
            titleTextField,
            mapImageView,
            descriptionTextView,
        ].forEach {self.addSubview($0)}
    }
    
    func setupConstraints() {
        configurePhotoImageViewConstraints()
        configureTitleTextFieldConstraints()
        configureMapImageViewConstraints()
        configureDescriptionTextViewConstraints()
        
        [
            photoImageView,
            titleTextField,
            mapImageView,
            descriptionTextView,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configurePhotoImageViewConstraints() {
        [
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            photoImageView.heightAnchor.constraint(equalToConstant: 200)
        ].forEach { $0.isActive = true }
    }
    
    private func configureTitleTextFieldConstraints() {
        [
            titleTextField.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ].forEach { $0.isActive = true }
    }
    
    private func configureMapImageViewConstraints() {
        [
            mapImageView.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            mapImageView.leadingAnchor.constraint(greaterThanOrEqualTo: titleTextField.trailingAnchor, constant: 16),
            mapImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
        ].forEach { $0.isActive = true }
    }
    
    private func configureDescriptionTextViewConstraints() {
        [
            descriptionTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            descriptionTextView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            descriptionTextView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            descriptionTextView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -100)
        ].forEach { $0.isActive = true }
    }
    
}

//MARK: Configurating view

extension EditNoteScreenView {
    
    func configureView(note: Note?) {
        if let note = note {
            self.note = note
            photoImageView.image = note.picture
            titleTextField.text = note.title
            descriptionTextView.text = note.text
        }
    }
    
}

//MARK: Configurating Interaction

extension EditNoteScreenView: UITextViewDelegate, UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.delegate?.didBeginEditing()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.note.title = textField.text ?? "1"
        self.delegate?.didEndEditing()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter the note" {
            textView.text = ""
        }
        self.delegate?.didBeginEditing()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Enter the note"
        }
        self.note.text = textView.text
        self.delegate?.didEndEditing()
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    @objc private func mapImageViewDidTap() {
        print(123)
    }
    
}


extension EditNoteScreenView {
    
    @objc private func photoImageViewDidTap() {
        self.delegate?.photoImageViewDidTap()
    }
    
    func updatephotoImageView(image: UIImage) {
        self.note.picture = image
        photoImageView.image = image
    }
    
}
