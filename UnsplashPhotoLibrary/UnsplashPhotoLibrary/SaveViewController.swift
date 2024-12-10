//
//  SaveViewController.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit
class SaveViewController: UIViewController {
    // MARK: - var property
    var dataSourse: [StorageModel] = []
//    var viewModel = SaveVCModel()
    
    // MARK: - lazy property
    private lazy var collectionView: UICollectionView = {
        var collection = UICollectionView(
            frame: CGRect(x:  UISet.N.position.rawValue,
                          y: Int(view.safeAreaInsets.top) + UISet.N.position.rawValue,
                          width: Int(view.bounds.width) - UISet.N.position.rawValue * 2,
                          height: Int(view.bounds.height - CGFloat((UISet.N.heightTitleLabel.rawValue + UISet.N.heightCVCell.rawValue)))),
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
        layout.minimumInteritemSpacing = CGFloat(1)
        layout.minimumLineSpacing = CGFloat(1)
        layout.scrollDirection = .vertical
        return layout
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    private  lazy var deleteBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(callAlertDelete))
        return barButtonItem
    }()

    // MARK: - LifeCycle func
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        dataSourse = DataManager.shared.obtainSaveData()
//        viewModel.obtainSaveData()
     //   bindViewModel()
        view.backgroundColor = .white
        setupBarButtonItems()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        setupConstraintsColectionView()
    }
    // MARK:  setup and conf. funcs
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItems = [deleteBarButton]
    }
    
    
//    func bindViewModel() {
//        self.viewModel.saveVCModel.bind { [weak self] items in
//            guard let self = self,
//                  let checkedData = items else{return}
//            self.dataSourse = checkedData
//            self.collectionView.reloadData()
//        }
//    }
    
    func setupConstraintsColectionView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    // MARK: - @objc funcs
    @objc
    func callAlertDelete(){
        DataManager.shared.removeAllObject()
        dataSourse = []
        collectionView.reloadData()
    }
}



