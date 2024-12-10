//
//  SaveCollectionViewCell.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class SaveCollectionViewCell: UICollectionViewCell{
    // MARK: - property
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    // MARK: - configure and UI Settings func
    func configereCell(by dataSourse: StorageModel){
        Task{
            imageView.image = DataManager.shared.loadImage(fileName: dataSourse.imageName)
        }
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
// MARK: - extension
extension SaveCollectionViewCell{
    static func obtainCellName() -> String{
        return "SaveCollectionViewCell"
    }
}
