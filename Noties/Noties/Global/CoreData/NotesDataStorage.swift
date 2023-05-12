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
            storedNote.location = note.location.description
            storedNote.date = note.date
            storedNote.username = UserDefaults.standard.object(forKey: "currentUser") as? String
            try! context.save()
        }
    }
    
    func update(note: Note, completion: @escaping () -> ()?) {
        context.perform {
            let fetchRequest = StoredNote.fetchRequest()
            guard
                let storedNotes = try? context.fetch(fetchRequest)
            else { return }

            if let storedNote = storedNotes.first(where: { $0.id == note.id }) {
                storedNote.id = note.id
                storedNote.title = note.title
                storedNote.text = note.text
                storedNote.picture = note.picture.jpegData(compressionQuality: 1)
                storedNote.location = note.location.description
                storedNote.date = note.date
                storedNote.username = UserDefaults.standard.object(forKey: "currentUser") as? String
            } else {
                save(note: note)
            }
            try! context.save()
            completion()
        }
    }
    
    func updateAll(notes: [Note]) {
        for note in notes {
            update(note: note, completion: {} )
        }
    }
    
    func fetchAll(completion: @escaping ([StoredNote]) -> ()?) {
        context.perform {
            let fetchRequest = StoredNote.fetchRequest()
            let storedNotes = try! context.fetch(fetchRequest)
            var userStoredNotes = storedNotes
            userStoredNotes.removeAll(where: { $0.username != UserDefaults.standard.object(forKey: "currentUser") as? String } )
            completion(userStoredNotes)
        }
    }

    func remove(by id: UUID) {
        context.perform {
            let fetchRequest = StoredNote.fetchRequest()
            guard
                let storedNotes = try? context.fetch(fetchRequest)
            else { return }
            for note in storedNotes where note.id == id {
                context.delete(note)
            }
        }
    }
    
}

