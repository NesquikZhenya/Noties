//
//  EditNoteScreenViewModel.swift
//  Noties
//
//  Created by Евгений Михневич on 10.05.2023.
//

import Foundation


protocol EditNoteDataManaging {
    func updateNote(note: Note)
}

final class EditNoteScreenViewModel {
        
    weak var delegate: EditNoteScreenViewModelListening?
    private var editNoteScreenDataManager: EditNoteDataUpdating

    init(editNoteScreenDataManager: EditNoteDataUpdating = EditNoteScreenDataManager()) {
        self.editNoteScreenDataManager = editNoteScreenDataManager
    }
    
}

//MARK: Manage the data

extension EditNoteScreenViewModel: EditNoteDataManaging {
    
    func updateNote(note: Note) {
        editNoteScreenDataManager.updateNoteData(note: note) {
            self.delegate?.closeViewController()
        }
    }
    
    func deleteNote(note: Note) {
        editNoteScreenDataManager.deleteNoteData(note: note)
    }
 
}
