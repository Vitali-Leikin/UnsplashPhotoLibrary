//
//  ViewController.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class FirstCollectionVC: UIViewController {
    // MARK: - var property
    var dataSource:[LoadedModel] = []
    var viewModel = FirstVCModel()
    private let refreshControl = UIRefreshControl()
    
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
        collection.backgroundColor = .white
        collection.register(CollectionViewCellImage.self, forCellWithReuseIdentifier: CollectionViewCellImage.obtainCellName())
        return collection
    }()
    
     lazy var layout: UICollectionViewFlowLayout = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.minimumInteritemSpacing = CGFloat(0)
        layout.minimumLineSpacing = CGFloat(0)
        layout.scrollDirection = .vertical
        return layout
    }()

    // MARK: - LifeCycle func
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        viewModel.getData()
        setupBarButtonItems()
        setupRefreshControl()
        swipeVCtoSaveVC()
    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        navigationItem.title = UISet.S.nameApp.rawValue
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
  
    func setupRefreshControl(){
        refreshControl.addTarget(self, action: #selector(appendNewElements), for: .valueChanged)
        collectionView.refreshControl = refreshControl
    }
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(openDetails))
    }
    
   private func swipeVCtoSaveVC(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(openDetails))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    // MARK: -  functions
    @MainActor
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
    
    // MARK: - refresh CollectionView func
    
    @objc
    func appendNewElements(){
        refreshControl.beginRefreshing()
        viewModel.getRefreshData()
        refreshControl.endRefreshing()
        reloadCollectionView()
    }
}



