//
//  EditNoteScreenViewModel.swift
//  Noties
//
//  Created by Евгений Михневич on 10.05.2023.
//

import Foundation


protocol EditNoteDataManaging {
    func updateNote(note: Note, completion: @escaping () -> ()?)
}

final class EditNoteScreenViewModel {
        
    private var editNoteDataManager: EditNoteDataUpdating

    init(editNoteDataManager: EditNoteDataUpdating = EditNoteScreenDataManager()) {
        self.editNoteDataManager = editNoteDataManager
    }
    
}

//MARK: Manage the data

extension EditNoteScreenViewModel: EditNoteDataManaging {
    
    func updateNote(note: Note, completion: @escaping () -> ()?) {
        editNoteDataManager.updateNoteData(note: note, completion: completion)
    }
    
    func deleteNote(note: Note) {
        editNoteDataManager.deleteNoteData(note: note)
    }
 
}
