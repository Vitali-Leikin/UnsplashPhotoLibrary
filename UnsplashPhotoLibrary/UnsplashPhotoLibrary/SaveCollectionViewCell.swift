//
//  SaveCollectionViewCell.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class SaveCollectionViewCell: UICollectionViewCell{
     
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()

    func configereCell(by dataSourse: StorageModel){
        imageView.image = DataManager.shared.loadImage(fileName: dataSourse.imageName)
        setupLayout()
    }

    private func setupLayout(){
        contentView.addSubview(imageView)
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                
                
            ]
        )
    }
}

extension SaveCollectionViewCell{
    static func obtainCellName() -> String{
        return "SaveCollectionViewCell"
    }
}
