//
//  MapsScreenDataManager.swift
//  Noties
//
//  Created by Евгений Михневич on 12.05.2023.
//

import Foundation

protocol NotesDataUpdating {
    func updateNotesData(notes: [Note])
}

struct MapsScreenDataManager {
    
    private let notesDataStorage = NotesDataStorage()
    
}

extension MapsScreenDataManager: NotesDataProviding, NotesDataUpdating {
    
    func provideNotesData(provideCompletion: @escaping ([StoredNote]) -> ()?) {
        
        let fetchCompletion = { (storedNotes: [StoredNote]) in
            provideCompletion(storedNotes)
        }
        
        notesDataStorage.fetchAll(completion: fetchCompletion)
    }
    
    func updateNotesData(notes: [Note]) {
        notesDataStorage.updateAll(notes: notes)
    }

}
