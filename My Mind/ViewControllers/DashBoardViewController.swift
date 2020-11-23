//
//  ViewController.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import UIKit

class DashBoardViewController: UIViewController, NavigationConfirming {
    
    

    private let stackViewContainer = UIStackView()
   
    private lazy var categoryScroll: CategoryScrollView = {
        CategoryScrollView(delegate: self) 
    }()
    
    private lazy var dataProvider = CategoryDataProvider(delegate: nil)

    private let bgImageView: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "bg"))
        return imageView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationBar()
        view.addSubview(bgImageView)
        view.addSubview(stackViewContainer)
        view.addSafeAreaConstraints(for: bgImageView, margin: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))

        view.addSafeAreaConstraints(for: stackViewContainer, margin: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0))
        configureStackViewContainer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
}

extension DashBoardViewController: CategoryScrollViewDelegate {
    func didSelectCategory(categroy: CategoryItem) {
        let newsFeedController = NewsFeedViewController(category: categroy, delegate: self)
        self.navigationController?.show(newsFeedController, sender: nil)
    }
    
}

extension DashBoardViewController: CategorySegmentControlDelegate {
    func didSelect(type: CategoryType) {
        categoryScroll.reloadView(with: type)
    }
}

extension DashBoardViewController: NewsFeedViewControllerDelegate {
    
    func didUpdate(category: CategoryItem, follow: Bool) {
        follow ? dataProvider.followCategory(category: category) : dataProvider.unFollowCategory(category: category)
        categoryScroll.reloadView(with: .following)
        
    }

}

private extension DashBoardViewController {
    
     func configureStackViewContainer() {
        stackViewContainer.axis = .vertical
        stackViewContainer.backgroundColor = .clear
        
        let segmentFrame = CGRect(x: 0, y: 50, width: self.view.frame.width, height: 50)
        let segmentControl = CategorySegmentControl(frame: segmentFrame, categories: dataProvider.getCategoryTypes(), delegate: self)
        segmentControl.backgroundColor = .clear
        segmentControl.addConstraint(forHeight: 60)
        segmentControl.setIdentifier(Identifiers.categoryTypeFilterView)
        stackViewContainer.addArrangedSubview(segmentControl)

        stackViewContainer.addArrangedSubview(categoryScroll.view)
        categoryScroll.view.setIdentifier(Identifiers.categroyListView)

        addChild(categoryScroll)
        categoryScroll.didMove(toParent: self)
        view.layoutIfNeeded()

    }
}

extension DashBoardViewController {
    public enum Identifiers: AccessibilityIdentifying {
        case categoryTypeFilterView
        case categroyListView
    }
}




