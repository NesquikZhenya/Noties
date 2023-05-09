//
//  NotesScreenViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

class NotesScreenViewController: UIViewController {

    private let notesScreenView = NotesScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = notesScreenView
    }

}
