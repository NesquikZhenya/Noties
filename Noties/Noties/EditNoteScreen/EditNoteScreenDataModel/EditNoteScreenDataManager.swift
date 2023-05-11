//
//  EditNoteScreenDataManager.swift
//  Noties
//
//  Created by Евгений Михневич on 10.05.2023.
//

import Foundation

protocol EditNoteDataUpdating {
    func updateNoteData(note: Note, completion: @escaping () -> ()?)
    func deleteNoteData(note: Note)
}

struct EditNoteScreenDataManager {
    
    private let notesDataStorage = NotesDataStorage()
    
}

extension EditNoteScreenDataManager: EditNoteDataUpdating {
    
    func updateNoteData(note: Note, completion: @escaping () -> ()?) {
        notesDataStorage.update(note: note, completion: completion)
    }
    
    func deleteNoteData(note: Note) {
        notesDataStorage.remove(by: note.id)
    }

}
