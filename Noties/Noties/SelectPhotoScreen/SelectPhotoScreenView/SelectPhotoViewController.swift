//
//  SelectPhotoViewController.swift
//  Noties
//
//  Created by Евгений Михневич on 09.05.2023.
//

import UIKit
import Photos

protocol SelectPhotoListening: AnyObject {
    func photoDidSelect(image: UIImage)
}

final class SelectPhotoViewController: UIViewController {
    
    weak var delegate: SelectPhotoListening?
    private var images: [PHAsset] = []
    
    private let selectPhotoCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view = selectPhotoCollectionView
        selectPhotoCollectionView.dataSource = self
        selectPhotoCollectionView.delegate = self
        selectPhotoCollectionView.register(SelectPhotoCollectionViewCell.self, forCellWithReuseIdentifier: "SelectPhotoCollectionViewCell")
        showPhotos()
    }
    
    private func showPhotos() {
        PHPhotoLibrary.requestAuthorization { [weak self] status in
            if status == .authorized {
                let assests = PHAsset.fetchAssets(with: PHAssetMediaType.image, options: nil)
                assests.enumerateObjects { (object, count, stop) in
                    self?.images.append(object)
                }
                self?.images.reverse()
                DispatchQueue.main.async {
                    self?.selectPhotoCollectionView.reloadData()
                }
            }
        }
    }

}

extension SelectPhotoViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.images.count
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = self.selectPhotoCollectionView.dequeueReusableCell(withReuseIdentifier: "SelectPhotoCollectionViewCell", for: indexPath) as? SelectPhotoCollectionViewCell {
            
            let asset = self.images[indexPath.row]
            let manager = PHImageManager.default()
            
            manager.requestImage(for: asset, targetSize: CGSize(width: ((UIScreen.main.bounds.width - 16*4)/3), height: ((UIScreen.main.bounds.width - 16*4)/3)), contentMode: .aspectFit, options: nil) { image, _ in
                
                DispatchQueue.main.async {
                    cell.configureCell(image: image!)
                }
                
            }
            return cell
        } else {
            return UICollectionViewCell()
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedAsset = self.images[indexPath.row]
        
        PHImageManager.default().requestImage(for: selectedAsset, targetSize: CGSize(width: 300, height: 300), contentMode: .aspectFit, options: nil) { [weak self] image, info in
            
            guard let info = info else { return }
            
            let isDegradedImage = info["PHImageResultIsDegradedKey"] as! Bool
            if !isDegradedImage {
                if let image = image {
                    self?.delegate?.photoDidSelect(image: image)
                    self?.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: ((UIScreen.main.bounds.width - 16*4)/3), height: ((UIScreen.main.bounds.width - 16*4)/3))
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 16
    }
    
}
