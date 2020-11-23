//
//  CategoryScrollView.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

protocol CategoryScrollViewDelegate: AnyObject {
    func didSelectCategory(categroy: CategoryItem)
}

class CategoryScrollView: UIViewController {
    
    private var collectionView: UICollectionView?
    private var coordinator: CategoryListCordinator?

    private lazy var dataProvider = CategoryDataProvider(delegate: self)

    private weak var delegate: CategoryScrollViewDelegate?

    init(delegate: CategoryScrollViewDelegate) {
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        reloadView(with: .following)
    }

    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()

        collectionView?.collectionViewLayout.invalidateLayout()
    }
    
    func reloadView(with categroyType: CategoryType) {
        dataProvider.getCategoryList(with: categroyType)
    }
}

extension CategoryScrollView: CategoryListCordinatorDelegate {
    func didSelect(category: CategoryItem) {
        delegate?.didSelectCategory(categroy: category)
    }

}

extension CategoryScrollView: CategoryDataProviderDelegate {
    func showError(messege: String?) {
        DispatchQueue.main.async {
            let alert = ErrorAlert.alert(from: messege ?? "Something went wrong")
            self.present(alert, animated: true)
        }
    }
    
    func didUpdate(with categories: [CategoryItem]) {
        DispatchQueue.main.async {
            self.updateCollectionView(with: categories)
        }
    }
}

private extension CategoryScrollView {
    func updateCollectionView(with data: [CategoryItem]) {
        collectionView?.removeFromSuperview()

        let cordinator = CategoryListCordinator(dataList: data, delegate: self)
        let collectionView = UICollectionView(coordinator: cordinator)
        collectionView.scrollsToTop = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.setIdentifier(Identifiers.categoryList)
        self.collectionView = collectionView
        self.coordinator = cordinator
        view.addSubviewWithConstraints(collectionView)
    }
}

extension CategoryScrollView {
    enum Identifiers: AccessibilityIdentifying {
        case categoryList
    }
}
