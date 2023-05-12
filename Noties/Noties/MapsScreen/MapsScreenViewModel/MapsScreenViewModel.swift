//
//  MapsScreenViewModel.swift
//  Noties
//
//  Created by Евгений Михневич on 12.05.2023.
//

import Foundation
import UIKit
import MapKit


final class MapsScreenViewModel {
    
    weak var delegate: MapsScreenViewModelListening?
    private var mapsScreenDataManager: NotesDataProviding & NotesDataUpdating

    init(mapsScreenDataManager: NotesDataProviding & NotesDataUpdating = MapsScreenDataManager()) {
        self.mapsScreenDataManager = mapsScreenDataManager
    }
    
}

//MARK: Manage the data

extension MapsScreenViewModel: NotesDataManaging {
    
    func getNotes() {
        
        let provideNotesCompletion = { (storedNotes: [StoredNote]) in
            self.delegate?.initializeMapsScreenView(notes: transformed(storedNotes: storedNotes))
        }
        
        mapsScreenDataManager.provideNotesData(provideCompletion: provideNotesCompletion)
                
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
    
    func getNoteByCoordinates(coordinate: CLLocationCoordinate2D) {
        
        let provideNotesCompletion = { (storedNotes: [StoredNote]) in
            self.delegate?.pushEditNoteScreenViewController(note: sorted(storedNotes: storedNotes))
        }
        
        mapsScreenDataManager.provideNotesData(provideCompletion: provideNotesCompletion)
                
        func sorted(storedNotes: [StoredNote]) -> Note? {
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
            return notes.first(where: { $0.location.description == coordinate.description })
        }
        
    }
    
    func updateNotes(notes: [Note]) {
        mapsScreenDataManager.updateNotesData(notes: notes)
    }
 

}
