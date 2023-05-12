//
//  SelectPhotoCollectionViewCell.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit

final class SelectPhotoCollectionViewCell: UICollectionViewCell {
    
    private let photoImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//MARK: Configurating constraints

extension SelectPhotoCollectionViewCell: ViewSetuping {
    
    func loadViews(){
        [
            photoImageView,
        ].forEach {self.contentView.addSubview($0)}
    }
    
    func setupConstraints() {
        configurePhotoImageViewConstraints()

        [
            photoImageView
        ].forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    }
    
    private func configurePhotoImageViewConstraints() {
        [
            photoImageView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            photoImageView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            photoImageView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            photoImageView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor)
        ].forEach { $0.isActive = true }
    }
  
}

//MARK: Configurating Cell

extension SelectPhotoCollectionViewCell {
    
    func configureCell(image: UIImage) {
        photoImageView.image = image
    }
    
}
