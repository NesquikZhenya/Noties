//
//  NotesDataManager.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import Foundation

protocol NotesDataProviding {
    func provideNotesData(provideCompletion: @escaping ([StoredNote])->()?)
}

protocol NotesDataUpdating {
    func updateNotesData(updateCompletion: @escaping ([StoredNote])->()?)
}

struct NotesDataManager {
    
    private let notesDataStorage = NotesDataStorage()
    
}

extension NotesDataManager: NotesDataProviding, NotesDataUpdating {
    
    func provideNotesData(provideCompletion: @escaping ([StoredNote]) -> ()?) {
        
        let fetchCompletion = { (storedNotes: [StoredNote]) in
            provideCompletion(storedNotes)
        }
        
        notesDataStorage.fetchAll(completion: fetchCompletion)
    }
    
    func updateNotesData(updateCompletion: @escaping ([StoredNote])->()?) {
        
    }

}
