//
//  CategoryServices.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-22.
//

import Foundation

// This class is created as singleton becasuse there is no API support on the
// category lists to add and remove from following list.
// This will make the app a bit more interactive

public final class CategoryServices {
    public static let `default` = CategoryServices()
        
    var categoryList: [CategoryItem] = []
    
    func fetchCategory(completion: @escaping ([CategoryItem]?, Error?) -> Void) {
        
        guard categoryList.isEmpty else {
            completion(categoryList, nil)
            return
        }
        
        NetworkService.default.getCategories { [self] (result) in
            switch result {
            case .success(let categories):
                self.categoryList = categories.list.sorted { $0.name < $1.name }
                completion(self.categoryList, nil)
                
            case .failure(let error):
                print(error)
                completion(nil, error)
            }
        }
        
    }
    
    func removeFromFollow(category: CategoryItem) {
        guard !categoryList.isEmpty else {
            return
        }
        
        var newCategoryList = categoryList.filter { $0 != category }
        let remainingAssociatedTypes = category.associatedTypes.filter { $0 != .following }
        newCategoryList.append(CategoryItem(name: category.name, imageUrl: category.imageUrl, associatedTypes: remainingAssociatedTypes, followers: category.followers))
        categoryList = newCategoryList.sorted { $0.name < $1.name }
    }
    
    
    func addToFollow(category: CategoryItem) {
        guard !categoryList.isEmpty else {
            return
        }
        
        var newCategoryList = categoryList.filter { $0 != category }
        var new: [CategoryType] = []
        
        category.associatedTypes.forEach { (type) in
            new.append(type)
        }
        new.append(.following)
        
        let newCategory = CategoryItem(name: category.name, imageUrl: category.imageUrl, associatedTypes: new, followers: category.followers)
        
        
        newCategoryList.append(newCategory)
        categoryList = newCategoryList.sorted { $0.name < $1.name }
    }
}
