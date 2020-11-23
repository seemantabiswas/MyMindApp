//
//  CategoryItem.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import Foundation

public enum CategoryType: String, Decodable, CaseIterable {
    case following
    case popular
    case explore
    
    static public var allCases: [CategoryType] {
            return [.following, .popular, .explore]
        }
}

public struct Categories: Decodable {
    public let list: [CategoryItem]
}

public struct CategoryItem: Decodable, Equatable {
    public let name: String
    public let imageUrl: String
    public let associatedTypes: [CategoryType]
    public let followers: String
}


