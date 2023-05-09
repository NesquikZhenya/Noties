//
//  EditNoteScreenViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

protocol EditNoteScreenViewListening: AnyObject {
    func photoImageViewDidTap()
}

final class EditNoteScreenViewController: UIViewController {

    private let editNoteScreenView = EditNoteScreenView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = editNoteScreenView
        editNoteScreenView.delegate = self
        let backButtondImage = UIImage(named: "back")
        self.navigationController?.navigationBar.backIndicatorImage = backButtondImage?.withTintColor(UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1))
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = backButtondImage
        self.navigationController?.navigationBar.tintColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
    }
    
}

extension EditNoteScreenViewController: EditNoteScreenViewListening {
    
    func photoImageViewDidTap() {
        let selectPhotoViewController = SelectPhotoViewController()
        selectPhotoViewController.delegate = self
        self.navigationController?.pushViewController(selectPhotoViewController, animated: true)
    }
    
}

extension EditNoteScreenViewController: SelectPhotoListening {
    
    func photoDidSelect(image: UIImage) {
        editNoteScreenView.updatephotoImageView(image: image)
    }
    
}
