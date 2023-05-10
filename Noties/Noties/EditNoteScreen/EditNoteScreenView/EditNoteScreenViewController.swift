//
//  EditNoteScreenViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

protocol EditNoteScreenViewListening: AnyObject {
    func photoImageViewDidTap()
    func didBeginEditing()
    func didEndEditing()
}

final class EditNoteScreenViewController: UIViewController {
    
    private let editNoteScreenViewModel = EditNoteScreenViewModel()
    private let editNoteScreenView = EditNoteScreenView()
    private lazy var deleteButton = UIBarButtonItem(title: "Delete", style: .plain, target: self, action: #selector(deleteNoteButtonDidTap))
    private lazy var doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneEditingNoteButtonDidTap))
    private var isDeletingNote = false

    override func viewDidLoad() {
        super.viewDidLoad()
        view = editNoteScreenView
        editNoteScreenView.delegate = self
        let backButtondImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backButtondImage?.withTintColor(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1))
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtondImage
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        self.navigationItem.rightBarButtonItem = deleteButton
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if self.isMovingFromParent && !isDeletingNote {
            editNoteScreenViewModel.updateNote(note: editNoteScreenView.note)
        }
    }
    
}

extension EditNoteScreenViewController {
    
    func configureEditNoteScreenView(note: Note?) {
        editNoteScreenView.configureView(note: note)
    }
    
    @objc private func deleteNoteButtonDidTap() {
        self.isDeletingNote = true
        editNoteScreenViewModel.deleteNote(note: editNoteScreenView.note)
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc private func doneEditingNoteButtonDidTap() {
        editNoteScreenView.endEditing(true)
    }
    
}

extension EditNoteScreenViewController: EditNoteScreenViewListening {
    
    func photoImageViewDidTap() {
        let selectPhotoViewController = SelectPhotoViewController()
        selectPhotoViewController.delegate = self
        self.navigationController?.pushViewController(selectPhotoViewController, animated: true)
    }
    
    func didBeginEditing() {
        self.navigationItem.rightBarButtonItem = doneButton
    }
    
    func didEndEditing() {
        self.navigationItem.rightBarButtonItem = deleteButton
    }
    
}

extension EditNoteScreenViewController: SelectPhotoListening {
    
    func photoDidSelect(image: UIImage) {
        editNoteScreenView.updatephotoImageView(image: image)
    }
    
}
