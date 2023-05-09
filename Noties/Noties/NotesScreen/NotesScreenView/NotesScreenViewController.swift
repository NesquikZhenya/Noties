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

final class NotesScreenViewController: UIViewController {

    private let notesScreenViewModel = NotesScreenViewModel()
    private let notesScreenView = NotesScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Here's your notes"
        self.navigationController?.title = "Notes"
        view = notesScreenView
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
