//
//  NotesScreenViewModel.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import Foundation
import UIKit
import MapKit


protocol NotesDataManaging {
    func getNotes()
}

final class NotesScreenViewModel {
    
    weak var delegate: NotesScreenViewModelListening?    
    private var notesScreenDataManager: NotesDataProviding

    init(notesScreenDataManager: NotesDataProviding = NotesScreenDataManager()) {
        self.notesScreenDataManager = notesScreenDataManager
    }
    
}

//MARK: Manage the data

extension NotesScreenViewModel: NotesDataManaging {
    
    func getNotes() {
        
        let provideNotesCompletion = { (storedNotes: [StoredNote]) in
            self.delegate?.initializeNotesScreenView(notes: transformed(storedNotes: storedNotes), name: storedNotes[0].username ?? "")
        }
        
        notesScreenDataManager.provideNotesData(provideCompletion: provideNotesCompletion)
                
        func transformed(storedNotes: [StoredNote]) -> [Note] {
            var notes: [Note] = []
            storedNotes.forEach {
                let note = Note(id: $0.id ?? UUID(),
                                title: $0.title ?? "",
                                text: $0.text ?? "",
                                picture: UIImage(data: $0.picture ?? Data())!,
                                location: CLLocationCoordinate2D(coords: $0.location ?? "0;0"),
                                date: $0.date ?? Date())
                notes.append(note)
            }
            return notes.sorted(by: { $0.date > $1.date })
            
        }
        
    }
 

}
