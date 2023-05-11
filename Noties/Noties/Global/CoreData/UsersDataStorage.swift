//
//  UsersDataStorage.swift
//  Noties
//
//  Created by Евгений Михневич on 11.05.2023.
//

import Foundation
import CoreData

struct UsersDataStorage {
    
    private let context = AppDataController.shared.context

    func save(user: User) {
        context.perform {
            let storedUser = StoredUser(context: context)
            storedUser.name = user.name
            storedUser.password = user.password
            try! context.save()
        }
    }
    
    func fetchAll(completion: @escaping ([StoredUser]) -> ()?) {
        context.perform {
            let fetchRequest = StoredUser.fetchRequest()
            let StoredUsers = try! context.fetch(fetchRequest)
            completion(StoredUsers)
        }
    }

}

