//
//  CollectionViewCellImage.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class CollectionViewCellImage: UICollectionViewCell {
    // MARK: - private property
    private var dataSource: CellViewModel?
    
    // MARK: - private lazy UI
    private let imageView: UIImageView = {
        let imageView = UIImageView()
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
        button.addTarget(self,action: #selector(pressedLikeButton), for: .touchUpInside)
        return button
    }()
    
    // MARK: - prepare CELL func
    override  func prepareForReuse() {
        super.prepareForReuse()
        if self.subviews.contains(likeButton){
            self.contentView.removeFromSuperview()
            imageView.image = .remove
        }
    }
    // MARK: -  @objc func
    @objc
   private func pressedLikeButton(){
        guard let dataSource = dataSource else {return}
        if dataSource.isLike{
            dataSource.isLike.toggle()
            DataManager.shared.removeOneObject(id: dataSource.id)
            likeButton.setImage(UIImage(systemName: UISet.S.heart.rawValue), for: .normal)
        }else{
            dataSource.isLike.toggle()
            DataManager.shared.saveCellobject(object: dataSource)
            likeButton.setImage(UIImage(systemName: UISet.S.heartFill.rawValue), for: .normal)
        }
    }
    // MARK: - setup Layout and cofigure Cell
    
    func configereCell(by dataSource: CellViewModel){
        guard let url = dataSource.imageUrl else {return}
        self.dataSource = dataSource
        let array =  DataManager.shared.obtainSaveData()
        
        for item in array{
            if item.id == dataSource.id{
            }
        }
        Task{
            do{
                let image = try await ImageNetworkManager.shared.downloadImage(by: url)
                imageView.image = image
            }catch{
                print("error load image")
                imageView.image = nil
                imageView.image = UIImage(systemName: UISet.S.errorLoadImg.rawValue)
            }
        }
        if dataSource.isLike {
            likeButton.setImage(UIImage(systemName: UISet.S.heartFill.rawValue), for: .normal)
        }else{
            likeButton.setImage(UIImage(systemName: UISet.S.heart.rawValue), for: .normal)
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
// MARK: - extension

extension CollectionViewCellImage{
    static func obtainCellName() -> String{
        return "CollectionViewCellImage"
    }
}
