//
//  NotesDataStorage.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import Foundation
import CoreData

struct NotesDataStorage {
    
    private let context = AppDataController.shared.context

    func save(note: Note) {
        context.perform {
            let storedNote = StoredNote(context: context)
            storedNote.id = note.id
            storedNote.title = note.title
            storedNote.text = note.text
            storedNote.picture = note.picture.jpegData(compressionQuality: 1)
            storedNote.location = note.location
            try! context.save()
        }
    }
    
    func update(note: Note) {
        context.perform {
            let fetchRequest = StoredNote.fetchRequest() as! NSFetchRequest<StoredNote>
            let storedNotes = try! context.fetch(fetchRequest)
            let storedNote = storedNotes.first(where: { $0.id == note.id })
            storedNote?.id = note.id
            storedNote?.title = note.title
            storedNote?.text = note.text
            storedNote?.picture = note.picture.jpegData(compressionQuality: 1)
            storedNote?.location = note.location
            try! context.save()
        }
    }
    
    func fetchAll(completion: @escaping ([StoredNote]) -> ()?) {
        context.perform {
            let fetchRequest = StoredNote.fetchRequest() as! NSFetchRequest<StoredNote>
            let storedNotes = try! context.fetch(fetchRequest)
            completion(storedNotes)
        }
    }

    func remove(by id: UUID) {
//        context.perform {
//            let fetchRequest = StoredNote.fetchRequest() as! NSFetchRequest<StoredNote>
//            let storedNotes = try! context.fetch(fetchRequest)
//            storedNotes.removeAll(where: { $0.id == id })
//            try! context.save()
//        }
    }
    
}

