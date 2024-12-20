//
//  FirstCollectionVC + Extension.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

// MARK: - Extension FirstCollectionVC
extension FirstCollectionVC: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionViewCellImage.obtainCellName(), for: indexPath) as? CollectionViewCellImage else{ return UICollectionViewCell()}
        if dataSource.count <= 0{
            reloadCollectionView()
        }
        cell.configereCell(by: CellViewModel(model: dataSource[indexPath.row]))
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        goToDetailViewController(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath)  {
        if indexPath.item == dataSource.count - 1{
            viewModel.getData()
            collectionView.reloadItems(at: [indexPath])
          //  reloadCollectionView()
        }
    }
}
