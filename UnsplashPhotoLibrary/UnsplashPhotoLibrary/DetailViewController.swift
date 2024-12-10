//
//  DetailViewController.swift
//  UnsplashPhotoLibrary
//
//  Created by Vitali on 10/12/2024.
//

import UIKit

class DetailViewController: UIViewController {
    // MARK: - private property
    private var viewModel: DetailVCModel
    private var dataSourseItem: [StorageModel] = []
    // MARK: - private Lazy property
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
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var authorNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .vertical
        stack.addArrangedSubview(descriptionImageLabel)
        stack.addArrangedSubview(authorNameLabel)
        return stack
    }()
    // MARK: - LifeCycle func
    init(viewModel: DetailVCModel) {
        self.viewModel = viewModel
        dataSourseItem = viewModel.obtainSavedData()
        super.init(nibName: nil, bundle: nil)

    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        setupBarButtonItems()
        checViewLikeButton()

    }
 
    override func viewIsAppearing(_ animated: Bool) {
        super.viewIsAppearing(animated)
        setupLayout()
        checViewLikeButton()
    }
    
    // MARK: - private
    
   private func checViewLikeButton(){
       for item in dataSourseItem{
           if self.viewModel.id! == item.id{
               self.viewModel.isLike = item.isLike
               likeBarButton.image = UIImage(systemName:"heart.fill" )
               break
           }else{
               likeBarButton.image = UIImage(systemName:"heart" )
           }
       }
    }
  
    // MARK: - @objc func
    @objc
    private func didSelectButtonClicked(_ sender: UIBarButtonItem) {
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
    
    // MARK: - setup Layout func

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
}
