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

protocol NotesScreenViewListening: NotesTableViewCellListening & AnyObject {
    func addNoteButtonDidTap()
    func editNoteViewDidTap(note: Note)
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
    
    override func viewWillAppear(_ animated: Bool) {
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
        let editNoteScreenViewController = EditNoteScreenViewController()
        editNoteScreenViewController.configureEditNoteScreenView(note: nil)
        self.tabBarController?.navigationController?.pushViewController(editNoteScreenViewController, animated: true)
    }
    
    func editNoteViewDidTap(note: Note) {
        let editNoteScreenViewController = EditNoteScreenViewController()
        editNoteScreenViewController.configureEditNoteScreenView(note: note)
        self.tabBarController?.navigationController?.pushViewController(editNoteScreenViewController, animated: true)
    }
    
    func mapNoteViewDidTap(note: Note?) {
        print(123)
    }
    
}

