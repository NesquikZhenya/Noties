//
//  LoginScreenViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 10.05.2023.
//

import UIKit

protocol LoginScreenViewModelListening: AnyObject {
    func initializeLoginScreenView(users: [User])
}

protocol LoginScreenViewListening: AnyObject {
    func loginUser(user: User, remember: Bool)
    func registerUser(user: User)
}

final class LoginScreenViewController: UIViewController {

    private let loginScreenViewModel = LoginScreenViewModel()
    private let loginScreenView = LoginScreenView()
    
    override func loadView() {
        if let username = UserDefaults.standard.object(forKey: "savedUser") as? String {
            let controller = NotiesTabBarController().forUsername(username: username)
            self.navigationController?.pushViewController(controller, animated: true)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginScreenView
        loginScreenView.delegate = self
        loginScreenViewModel.delegate = self
        loginScreenViewModel.getUsers()
    }
    
}

extension LoginScreenViewController: LoginScreenViewModelListening {
  
    func initializeLoginScreenView(users: [User]) {
        DispatchQueue.main.async {
            self.loginScreenView.configureView(users: users)
        }
    }
    
}

extension LoginScreenViewController: LoginScreenViewListening {
    
    func loginUser(user: User, remember: Bool) {
        if remember {
            UserDefaults.standard.set(user.name, forKey: "savedUser")
        }
        let controller = NotiesTabBarController().forUsername(username: user.name)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
    func registerUser(user: User) {
        loginScreenViewModel.saveUser(user: user)
        loginScreenViewModel.getUsers()
    }
    
}
