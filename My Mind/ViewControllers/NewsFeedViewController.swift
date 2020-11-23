//
//  NewsFeedViewController.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-22.
//

import UIKit

protocol NewsFeedViewControllerDelegate: AnyObject {
    func didUpdate(category: CategoryItem, follow: Bool)
}

class NewsFeedViewController: UIViewController, NavigationConfirming {

    private var collectionView: UICollectionView?
    private var coordinator: NewsFeedViewCoordinator?

    private lazy var dataProvider = NewsFeedDataProvider(delegate: self)
    private weak var delegate: NewsFeedViewControllerDelegate?

    private var spinner: UIActivityIndicatorView?
    
    private let category: CategoryItem

    init(category: CategoryItem, delegate: NewsFeedViewControllerDelegate) {
        self.category = category
        self.delegate = delegate
        
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadView()
        let backButton = UIBarButtonItem( image: UIImage(named: "backButton"), style: .done, target: self, action: #selector(self.didTapBack))

        self.navigationItem.backBarButtonItem = backButton
        
        configureNavigationBar()

    }
    
    @objc func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func reloadView() {
        spinner = UIActivityIndicatorView().showLoader(view: view)
        dataProvider.getNews(with: category.name)
    }
}


extension NewsFeedViewController: NewsFeedDataProviderDelegate {
    func didUpdate(with feeds: [NewsFeed]) {
        DispatchQueue.main.async {
            self.updateCollectionView(with: feeds, category: self.category)
            self.spinner?.dismissLoader(view: self.view)
        }
    }
    
    func showError(messege: String?) {
        DispatchQueue.main.async {
            let alert = ErrorAlert.alert(from: messege ?? "Something went wrong")
            self.present(alert, animated: true)
        }
    }
}

extension NewsFeedViewController: NewsFeedViewCoordinatorDelegate {
    func didSelectFeed(feed: NewsFeed) {
        let controller = NewsDetailsViewController(nibName: String(describing: NewsDetailsViewController.self), bundle: .main)
        controller.configureView(with: category.name, feed: feed)
        
        let navController = UINavigationController(rootViewController: controller)
        navController.modalPresentationStyle = .fullScreen
        self.present(navController, animated: true, completion: nil)
    }
    
    func didTapFollow(for category: CategoryItem) {
        delegate?.didUpdate(category: category, follow: !category.associatedTypes.contains(.following))
    }
    
    
}

private extension NewsFeedViewController {
    func updateCollectionView(with data: [NewsFeed], category: CategoryItem) {
        collectionView?.removeFromSuperview()

        let cordinator = NewsFeedViewCoordinator(category: category, newFeeds: data, delegate: self)
        let collectionView = UICollectionView(coordinator: cordinator)
        collectionView.scrollsToTop = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .white
        collectionView.setIdentifier(Identifiers.categoryList)
        self.collectionView = collectionView
        self.coordinator = cordinator
        view.addSubviewWithConstraints(collectionView)
    }
}

extension NewsFeedViewController {
    enum Identifiers: AccessibilityIdentifying {
        case categoryList
    }
}
