//
//  SaveViewController + Extension.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

// MARK: - extension SaveViewController

extension SaveViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        dataSourse.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SaveCollectionViewCell.obtainCellName(), for: indexPath) as? SaveCollectionViewCell else {return UICollectionViewCell()}
        cell.configereCell(by: dataSourse[indexPath.row])
        return cell
    }
    
}
