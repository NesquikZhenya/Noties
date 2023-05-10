//
//  NotesScreenDataManager.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import Foundation

protocol NotesDataProviding {
    func provideNotesData(provideCompletion: @escaping ([StoredNote])->()?)
}

struct NotesScreenDataManager {
    
    private let notesDataStorage = NotesDataStorage()
    
}

extension NotesScreenDataManager: NotesDataProviding {
    
    func provideNotesData(provideCompletion: @escaping ([StoredNote]) -> ()?) {
        
        let fetchCompletion = { (storedNotes: [StoredNote]) in
            provideCompletion(storedNotes)
        }
        
        notesDataStorage.fetchAll(completion: fetchCompletion)
    }

}
