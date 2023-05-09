//
//  NotesScreenViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

protocol NotesScreenViewModelListening: AnyObject {
    func initializeNotesScreenView(notes: [Note])
}

protocol NotesScreenViewListening: AnyObject {
    func addNoteButtonDidTap()
}

final class NotesScreenViewController: UIViewController {

    private let notesScreenViewModel = NotesScreenViewModel()
    private let notesScreenView = NotesScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = notesScreenView
        notesScreenView.delegate = self
        notesScreenViewModel.delegate = self
        notesScreenViewModel.getNotes()
    }

}

extension NotesScreenViewController: NotesScreenViewModelListening {
    func initializeNotesScreenView(notes: [Note]) {
        DispatchQueue.main.async {
            self.notesScreenView.configureView(notes: notes)
        }
    }
}

extension NotesScreenViewController: NotesScreenViewListening {
    func addNoteButtonDidTap() {
        self.tabBarController?.navigationController?.pushViewController(EditNoteScreenViewController(), animated: true)
    }
}

