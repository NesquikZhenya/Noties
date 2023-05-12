//
//  MapsScreenView.swift
//  Noties
//
//  Created by Евгений Михневич on 12.05.2023.
//

import UIKit
import MapKit

final class MapsScreenView: MKMapView {
    
    weak var editDelegate: MapsScreenViewListening?
    
    private var coordinates = CLLocationCoordinate2D()
    
    private lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Edit", for: .normal)
        button.backgroundColor = UIColor(red: 0.004, green: 0, blue: 0.208, alpha: 1)
        button.layer.cornerRadius = 8
        button.isHidden = true
        button.addTarget(self, action: #selector(editButtonDidTap), for: .touchUpInside)
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        loadViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

//MARK: Configurating constraints

extension MapsScreenView: ViewSetuping {
    
    func loadViews(){
        [
            editButton
        ].forEach {self.addSubview($0)}
    }
    
    func setupConstraints() {
        configureEditButtonConstraints()
        
        [
            editButton
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configureEditButtonConstraints() {
        [
            editButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 50),
            editButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -70),
            editButton.widthAnchor.constraint(equalToConstant: 80),
            editButton.heightAnchor.constraint(equalToConstant: 40)
        ].forEach { $0.isActive = true }
    }
    
}

//MARK: Configurating view

extension MapsScreenView {
    
    func toggleButton() {
        editButton.isHidden.toggle()
    }
    
    func setCoordinates(coordinates: CLLocationCoordinate2D) {
        self.coordinates = coordinates
    }
    
    @objc private func editButtonDidTap() {
        self.editDelegate?.editButtonDidTap(noteCoordinates: self.coordinates)
    }
    
}
