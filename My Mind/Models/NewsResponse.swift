//
//  NewsResponse.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-22.
//

import Foundation

public struct NewResponse: Decodable {
    let type: String
    let totalCount: Int
    let feeds: [NewsFeed]

    enum CodingKeys: String, CodingKey {
        case type = "_type"
        case totalCount
        case feeds = "value"
    }
}

public struct NewsFeed: Decodable {
    let id, title: String
    let url: String
    let description, body, keywords, language: String
    let isSafe: Bool
    let datePublished: String
    let provider: Provider
    let image: Image?
}

public struct Image: Decodable {
    let url: String
}

public struct Provider: Decodable {
    let name: String
}

