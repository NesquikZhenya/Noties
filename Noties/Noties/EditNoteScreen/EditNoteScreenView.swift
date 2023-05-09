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
    
    private let picker = UIImagePickerController()

    private let titleTextField: UITextField = {
        let textField = UITextField()
        textField.font = .systemFont(ofSize: 24, weight: .semibold)
        textField.placeholder = "Enter the title"
        return textField
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
    
    @objc func dismissKeyboard() {
        self.endEditing(true)
    }
    
}

//MARK: Configurating constraints

extension EditNoteScreenView: ViewSetuping {
    
    func loadViews(){
        [
            photoImageView,
            titleTextField,
            descriptionTextView,
        ].forEach {self.addSubview($0)}
    }
    
    func setupConstraints() {
        configurePhotoImageViewConstraints()
        configureTitleTextFieldConstraints()
        configureDescriptionTextViewConstraints()
        
        [
            photoImageView,
            titleTextField,
            descriptionTextView,
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configurePhotoImageViewConstraints() {
        [
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 100),
            photoImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 24),
            photoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -24),
            photoImageView.heightAnchor.constraint(equalToConstant: 200)
        ].forEach { $0.isActive = true }
    }
    
    private func configureTitleTextFieldConstraints() {
        [
            titleTextField.topAnchor.constraint(equalTo: photoImageView.bottomAnchor, constant: 16),
            titleTextField.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            titleTextField.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
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
            photoImageView.image = note.picture
            titleTextField.text = note.title
            descriptionTextView.text = note.text
        }
    }
    
    func addPhotoImageViewGesture(gesture: UITapGestureRecognizer) {
        photoImageView.addGestureRecognizer(gesture)
    }
    
}

//MARK: Configurating Interaction

extension EditNoteScreenView: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "Enter the note" {
            textView.text = ""
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Enter the note"
        }
    }
    
}

extension EditNoteScreenView {
    
    @objc private func photoImageViewDidTap() {
        self.delegate?.photoImageViewDidTap()
    }
    
    func updatephotoImageView(image: UIImage) {
        photoImageView.image = image
    }
}
