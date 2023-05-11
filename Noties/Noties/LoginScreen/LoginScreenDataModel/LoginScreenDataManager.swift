//
//  LoginScreenDataManager.swift
//  Noties
//
//  Created by Евгений Михневич on 11.05.2023.
//

import Foundation

protocol UserDataProvidingAndSaving {
    func provideUsersData(provideCompletion: @escaping ([StoredUser])->()?)
    func updateUserData(user: User)
}

struct UserDataManager {
    
    private let usersDataStorage = UsersDataStorage()
    
}

extension UserDataManager: UserDataProvidingAndSaving {
    
    func provideUsersData(provideCompletion: @escaping ([StoredUser]) -> ()?) {
        
        let fetchCompletion = { (storedUsers: [StoredUser]) in
            provideCompletion(storedUsers)
        }
        
        usersDataStorage.fetchAll(completion: fetchCompletion)
    }
    
    func updateUserData(user: User) {
        usersDataStorage.save(user: user)
    }

}
