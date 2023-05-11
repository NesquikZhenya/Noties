//
//  LoginScreenViewModel.swift
//  Noties
//
//  Created by Евгений Михневич on 11.05.2023.
//

import Foundation


protocol UserDataManaging: AnyObject {
    func getUsers()
    func saveUser(user: User)
}

final class LoginScreenViewModel {
        
    weak var delegate: LoginScreenViewModelListening?
    private var usersDataManager: UserDataProvidingAndSaving

    init(usersDataManager: UserDataProvidingAndSaving = UserDataManager()) {
        self.usersDataManager = usersDataManager
    }
    
}

//MARK: Manage the data

extension LoginScreenViewModel: UserDataManaging {
    
    func getUsers() {
        let provideUsersCompletion = { (storedUsers: [StoredUser]) in
            self.delegate?.initializeLoginScreenView(users: transformed(storedUsers: storedUsers))
        }
        
        usersDataManager.provideUsersData(provideCompletion: provideUsersCompletion)
                
        func transformed(storedUsers: [StoredUser]) -> [User] {
            var users: [User] = []
            storedUsers.forEach {
                let user = User(name: $0.name ?? "", password: $0.password ?? "")
                users.append(user)
            }
            return users
        }
            
    }
    
    func saveUser(user: User) {
        usersDataManager.updateUserData(user: user)
    }
 
}
