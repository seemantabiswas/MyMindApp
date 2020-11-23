//
//  NewsFeedDataProvider.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-22.
//

import Foundation

import Foundation

protocol NewsFeedDataProviderDelegate: AnyObject {
    func didUpdate(with feeds: [NewsFeed])
    func showError(messege: String?)
}

class NewsFeedDataProvider {
    
    private weak var delegate: NewsFeedDataProviderDelegate?
    
    private var categoryList: [CategoryItem] = []
    
    init(delegate: NewsFeedDataProviderDelegate?) {
        self.delegate = delegate
    }
    
    
    func getNews(with query: String) {
        NetworkService.default.getNews(for: query) { (result) in
            switch result {
            case .success(let response):
                self.delegate?.didUpdate(with: response.feeds)
            case .failure(let error):
                self.delegate?.showError(messege: error.localizedDescription)
                print(error)
            }
        }
    }
    
}


