//
//  URLQueryItem+Extension.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-22.
//

import Foundation

public extension URLQueryItem {

    static func pageSize(_ pageSize: String) -> URLQueryItem {
        URLQueryItem(name: "pageSize", value: pageSize)
    }
    
    static func queryString(_ queryString: String) -> URLQueryItem {
        URLQueryItem(name: "q", value: queryString)
    }
    static func autoCorrect(_ autoCorrect: String) -> URLQueryItem {
        URLQueryItem(name: "autoCorrect", value: autoCorrect)
    }
    static func pageNumber(_ pageNumber: String) -> URLQueryItem {
        URLQueryItem(name: "pageNumber", value: pageNumber)
    }
   
}

