//
//  CategoryDataProvider.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//
import Foundation

public protocol CategoryDataProviderDelegate: AnyObject {
    func didUpdate(with categories: [CategoryItem])
    func showError(messege: String?)
}

public class CategoryDataProvider {
    
    private weak var delegate: CategoryDataProviderDelegate?
    
    private var categoryList: [CategoryItem] = []
    
    init(delegate: CategoryDataProviderDelegate?) {
        self.delegate = delegate
    }
    
    func getCategoryTypes() -> [CategoryType] {
        return CategoryType.allCases
    }
    
    func getCategoryList(with type: CategoryType) {
        
        CategoryServices.default.fetchCategory { (categoryList, error) in
            guard let list = categoryList else {
                self.delegate?.showError(messege: error?.localizedDescription)
                return
            }
            self.delegate?.didUpdate(with: list.filter{ $0.associatedTypes.contains(type)})
        }
    }
    
    func followCategory(category: CategoryItem) {
        CategoryServices.default.addToFollow(category: category)
    }
    
    func unFollowCategory(category: CategoryItem) {
        CategoryServices.default.removeFromFollow(category: category)
    }
    
}
