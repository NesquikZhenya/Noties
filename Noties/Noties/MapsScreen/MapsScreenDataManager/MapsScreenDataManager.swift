//
//  MapsScreenDataManager.swift
//  Noties
//
//  Created by Евгений Михневич on 12.05.2023.
//

import Foundation

struct MapsScreenDataManager {
    
    private let notesDataStorage = NotesDataStorage()
    
}

extension MapsScreenDataManager: NotesDataProviding {
    
    func provideNotesData(provideCompletion: @escaping ([StoredNote]) -> ()?) {
        
        let fetchCompletion = { (storedNotes: [StoredNote]) in
            provideCompletion(storedNotes)
        }
        
        notesDataStorage.fetchAll(completion: fetchCompletion)
    }

}
