//
//  NoteDataModel.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import Foundation
import UIKit

struct Note {
    let id: UUID
    let title: String
    let text: String
    let picture: UIImage
    let location: String
}
