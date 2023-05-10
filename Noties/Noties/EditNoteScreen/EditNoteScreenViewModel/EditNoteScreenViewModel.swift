//
//  EditNoteScreenViewModel.swift
//  Noties
//
//  Created by Евгений Михневич on 10.05.2023.
//

import Foundation


protocol EditNoteDataManaging: AnyObject {
    func updateNote(note: Note)
}

final class EditNoteScreenViewModel {
    
    private let notesDataStorage = NotesDataStorage()
    
    private var editNoteDataManager: EditNoteDataUpdating

    init(editNoteDataManager: EditNoteDataUpdating = EditNoteScreenDataManager()) {
        self.editNoteDataManager = editNoteDataManager
    }
    
}

//MARK: Manage the data

extension EditNoteScreenViewModel: EditNoteDataManaging {
    
    func updateNote(note: Note) {
        editNoteDataManager.updateNoteData(note: note)
    }
    
    func deleteNote(note: Note) {
        editNoteDataManager.deleteNoteData(note: note)
    }
 
}
