//
//  ViewController.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class FirstCollectionVC: UIViewController {
    // MARK: - var property
    
    var viewModel: FirstVCModel = FirstVCModel()
    var dataSource:[LoadedModel] = []

    // MARK: - lazy property
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
        collection.register(CollectionViewCellImage.self, forCellWithReuseIdentifier: CollectionViewCellImage.obtainCellName())
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
    
    
//    override func loadView() {
//        super.loadView()
//    }
    // MARK: - LifeCycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.getData()
        setupBarButtonItems()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        setupConstraintsColectionView()
        bindViewModel()
    }
    
    
    // MARK: - Setup Layout func
    func setupConstraintsColectionView(){
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(openDetails))
    }
    
    
    // MARK: -  functions
    func bindViewModel() {
        viewModel.cellDataSource.bind { [weak self] itemData in
            guard let self = self,
                  let imageData = itemData else {
                return
            }
            self.dataSource = imageData
            self.reloadCollectionView()
        }
    }
    
    @objc
    func openDetails() {
        let controller = SaveViewController()
        self.navigationController?.pushViewController(controller, animated: true)
    }
    

    //    MARK: - remove
    //    private func createLayout() -> UICollectionViewLayout {
    //        // section -> groups -> items -> size
    //        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
    //                                              heightDimension: .fractionalHeight(1.0))
    //        let item = NSCollectionLayoutItem(layoutSize: itemSize)
    //        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3),
    //                                               heightDimension: .fractionalWidth(0.3))
    //        //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
    //        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, repeatingSubitem: item, count: 3)
    //
    //        let spacing = CGFloat(1)
    //        group.interItemSpacing = .fixed(spacing)
    //        let section = NSCollectionLayoutSection(group: group)
    //        section.interGroupSpacing = spacing
    //        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: spacing, bottom: 0, trailing: spacing)
    //        let layout = UICollectionViewCompositionalLayout(section: section)
    //        return layout
    //    }
    
    
    func reloadCollectionView(){
        DispatchQueue.main.async{
            self.collectionView.reloadData()
        }
    }
    
    func goToDetailViewController(indexPath: IndexPath){
        let detailsModel = DetailVCModel(model: dataSource[indexPath.row])
        let controller = DetailViewController(viewModel: detailsModel)
        self.navigationController?.pushViewController(controller, animated: true)
    }
    
}



