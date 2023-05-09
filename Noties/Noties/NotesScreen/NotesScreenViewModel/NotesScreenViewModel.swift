//
//  NotesScreenViewModel.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import Foundation
import UIKit


protocol NotesDataManaging: AnyObject {
    func getNotes()
    func updateNote(note: Note)
}

final class NotesScreenViewModel {
    
    weak var delegate: NotesScreenViewModelListening?
    private let notesDataStorage = NotesDataStorage()
    
    private var notesDataProvider: NotesDataProviding
    private var notes: [Note] = []

    init(notesDataProvider: NotesDataProviding = NotesDataManager()) {
        self.notesDataProvider = notesDataProvider
    }
    
}

//MARK: Manage the data

extension NotesScreenViewModel: NotesDataManaging {
    
    func getNotes() {
        
        let provideNotesCompletion = { (storedNotes: [StoredNote]) in
            self.delegate?.initializeNotesScreenView(notes: transformed(storedNotes: storedNotes))
        }
        
        notesDataProvider.provideNotesData(provideCompletion: provideNotesCompletion)
                
        func transformed(storedNotes: [StoredNote]) -> [Note] {
            var notes: [Note] = []
            storedNotes.forEach {
                let note = Note(id: $0.id ?? UUID(),
                                title: $0.title ?? "",
                                text: $0.text ?? "",
                                picture: UIImage(data: $0.picture ?? Data())!,
                                location: $0.location ?? "")
                notes.append(note)
            }
//            return notes
            return [Note(id: UUID(), title: "Meow", text: "adasdaasd", picture: UIImage(named: "plus")!, location: ""),
                    Note(id: UUID(), title: "Purr", text: "", picture: UIImage(named: "attach")!, location: ""),
                    Note(id: UUID(), title: "Kiss", text: "123 123 123 \(/n/) 123123", picture: UIImage(named: "profile")!, location: "")
            ]
        }
        
    }
 
    func updateNote(note: Note) {
    }

}
