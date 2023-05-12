//
//  NoteDataModel.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import Foundation
import UIKit
import MapKit

struct Note {
    let id: UUID
    var title: String
    var text: String
    var picture: UIImage
    var location: CLLocationCoordinate2D
    var date: Date
}
