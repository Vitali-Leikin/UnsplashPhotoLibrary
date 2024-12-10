//
//  DetailViewController.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class DetailViewController: UIViewController {
    
    var viewModel: DetailVCModel
    var dataSourseItem: [StorageModel] = []
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private lazy var descriptionImageLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
      //  label.backgroundColor = .green
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
     //   label.backgroundColor = .green
        label.numberOfLines = 0
        label.textAlignment = .natural
        return label
    }()
    
    private lazy var likeBarButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(image: UIImage(systemName:"heart"), style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
        return barButtonItem
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
      //  stack.backgroundColor = .red
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.addArrangedSubview(descriptionImageLabel)
        stack.addArrangedSubview(authorNameLabel)
        return stack
    }()
    

    init(viewModel: DetailVCModel) {
        self.viewModel = viewModel
        dataSourseItem = viewModel.obtainSavedData()
        
        for item in dataSourseItem{
            if self.viewModel.id! == item.id{
                self.viewModel.isLike = item.isLike
            }
        }
        super.init(nibName: nil, bundle: nil)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBarButtonItems()

    }
    
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        setupLayout()
        checViewLikeButton()
    }
    
    func checViewLikeButton(){
        for item in dataSourseItem{
            if viewModel.id == item.id && item.isLike{
                likeBarButton.image = UIImage(systemName:"heart.fill" )
            }else{
                likeBarButton.image = UIImage(systemName:"heart" )
            }
        }
    }
    
  
    @objc private func didSelectButtonClicked(_ sender: UIBarButtonItem) {
        if viewModel.isLike == true{
            likeBarButton.image = UIImage(systemName:"heart" )
            viewModel.isLike.toggle()
            viewModel.removeObject()
        }else{
            likeBarButton.image = UIImage(systemName:"heart.fill" )
            viewModel.isLike.toggle()
            viewModel.saveObject(image: imageView.image)
        }
    }
 
    @objc
    private func callAlertDelete(_ sender: UIBarButtonItem){
        viewModel.removeObject()
    }

    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItems = [likeBarButton]
    }
    
    
    private func configure(){
        view.backgroundColor = .white
        guard let stringURL = viewModel.imageUrl else{return}
        Task{
            do{
                imageView.image = try await ImageNetworkManager.shared.downloadImage(by:stringURL)
                self.descriptionImageLabel.text = viewModel.description
            }catch{
                imageView.image = UIImage(systemName: "xmark.icloud")
                descriptionImageLabel.text = ""
                likeBarButton.isEnabled = false
            }
        }
    }
 
    private func setupLayout(){
        view.addSubview(imageView)
        view.addSubview(stackView)
        
        NSLayoutConstraint.activate(
            [
                imageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
                imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
                imageView.bottomAnchor.constraint(equalTo: view.centerYAnchor),
                stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 30),
                stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
                stackView.bottomAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.bottomAnchor)
            ]
        )
    }
    
    //    func saveObject(image: UIImage ){
    //        guard let img = imageView.image else{return}
    //
    //        let imageSave = DataManager.shared.saveImage(image: img)
    //        guard let checkSaveImg = imageSave, let describ = viewModel.description, let checkID = viewModel.id else {return}
    //
    //        let objectSave = Item(imageName: checkSaveImg, textComment: describ, id: checkID, isLike: viewModel.isLike)
    //        DataManager.shared.saveData([objectSave])
    //
    //    }

    //    private func removeObject(){
    //        print("remove")
    //        viewModel.isLike = false
    //        DataManager.shared.deleteOneObject(id: viewModel.id!)
    //    }

}
