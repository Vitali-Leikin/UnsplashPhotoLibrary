//
//  SaveViewController.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit
class SaveViewController: UIViewController {

    var dataSourse: [StorageModel] = []
    
    lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(
            frame: CGRect(x:  UIProperty.position.rawValue,
                          y: Int(view.safeAreaInsets.top) + UIProperty.position.rawValue,
                          width: Int(view.bounds.width) - UIProperty.position.rawValue * 2,
                          height: Int(view.bounds.height - CGFloat((UIProperty.heightTitleLabel.rawValue + UIProperty.heightCVCell.rawValue)))),
            collectionViewLayout: layout)
        
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.delegate = self
        collection.dataSource = self
        collection.isUserInteractionEnabled = true
        collection.backgroundColor = .gray
        collection.register(SaveCollectionViewCell.self, forCellWithReuseIdentifier: SaveCollectionViewCell.obtainCellName())
        return collection
    }()
    
    

    private lazy var layout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let wSize = ((view.bounds.size.width - 3) / 3)
        layout.itemSize = CGSize(width: wSize, height: wSize)
        //CGSize(width: Int((view.bounds.width) - CGFloat(positionX)) / 2, height: heightCVCell)
        layout.minimumInteritemSpacing = CGFloat(1)
        layout.minimumLineSpacing = CGFloat(1)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        //  imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
        private  lazy var deleteBarButton: UIBarButtonItem = {
            let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(callAlertDelete))
            return barButtonItem
        }()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourse = DataManager.shared.obtainSaveData()
        view.backgroundColor = .white
        setupBarButtonItems()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        setupConstraintsColectionView()
    }
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItems = [deleteBarButton]
    }
    
    func setupConstraintsColectionView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
    }
    
    @objc
    func callAlertDelete(){
        print("Delete ALL")
        DataManager.shared.removeAllObject()
        dataSourse = []
        collectionView.reloadData()
    }
}



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

