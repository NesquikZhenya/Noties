//
//  LoginScreenViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 10.05.2023.
//

import UIKit

class LoginScreenViewController: UIViewController {

    private let loginScreenView = LoginScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = loginScreenView
    }
    
}
