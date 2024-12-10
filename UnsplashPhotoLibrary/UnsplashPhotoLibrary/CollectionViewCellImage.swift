//
//  CollectionViewCellImage.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class CollectionViewCellImage: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
      //  imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    private let likeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        var config = UIButton.Configuration.plain()
        config.buttonSize = .large
        config.baseForegroundColor = .green
        button.configuration = config
        return button
    }()
    override func prepareForReuse() {
        super.prepareForReuse()
        if self.subviews.contains(likeButton){
            self.contentView.removeFromSuperview()
            imageView.image = .remove

        }
    }
    func configereCell(by dataSourse: CellViewModel){
       guard let url = dataSourse.imageUrl else {return}
        Task{
            do{
                let image = try await ImageNetworkManager.shared.downloadImage(by: url)
                imageView.image = image
            }catch{
                print("error load image")
            }
        }
        if dataSourse.isLike {
            likeButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            likeButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
        setupLayout()
    }
    private func setupLayout(){
        contentView.addSubview(imageView)
        contentView.addSubview(likeButton)
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
                likeButton.topAnchor.constraint(equalTo: contentView.centerYAnchor),
                likeButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                likeButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ]
        )
    }
}


extension CollectionViewCellImage{
    static func obtainCellName() -> String{
        return "CollectionViewCellImage"
    }
}
