//
//  CLLocationCoordinate2D.swift
//  Noties
//
//  Created by Евгений Михневич on 12.05.2023.
//

import MapKit

extension CLLocationCoordinate2D {
    init(coords : String)
    {
        self.init()
        let charArr = coords.split(separator: ";")
        var stringArr: [String] = []
        charArr.forEach { stringArr.append(String($0)) }
        self.latitude = NumberFormatter().number(from: stringArr[0])!.doubleValue
        self.longitude = (stringArr.count > 1) ? NumberFormatter().number(from: stringArr[1])!.doubleValue : 0
    }

    public var description : String
    {
        return "\(self.latitude);\(self.longitude)"
    }
}
