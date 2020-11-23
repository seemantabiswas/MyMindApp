//
//  NetworkServices.swift
//  My Mind
//
//  Created by Seemanta Biswas on 2020-11-21.
//

import Foundation

enum HTTPMethods: String {
    case get = "GET"
}

let headers = [
    "x-rapidapi-key": "af4763dde4mshfaab7100f002a2ap1557f8jsnde2fb06a44a9",
    "x-rapidapi-host": "contextualwebsearch-websearch-v1.p.rapidapi.com"
]

public enum APIError: Error {
    case decodeError(error: Error)
    case unknown
    case general(error: Int)
}

enum Endpoints {
    case newsApi(String)
    
    static let baseURLComponent: URLComponents = {
        var component = URLComponents()
        component.scheme = "https"
        component.host = "contextualwebsearch-websearch-v1.p.rapidapi.com"
        return component
    }()
    
    var path: String {
        switch self {
        case .newsApi:
            return "/api/search/NewsSearchAPI"
        }
    }
    
    
    var url: URL {
        var components = Endpoints.baseURLComponent

        switch self {
        case .newsApi(let queryString):
            components.path = path
            
            components.queryItems = [
                .pageSize("10"),
                .queryString(queryString),
                .autoCorrect("true"),
                .pageNumber("1"),
            ]
        }
        
        guard let url = components.url else {
            fatalError()
        }
    
        return url
    }
}

protocol NetworkServiceProtocol {
    func makeRequest<T: Decodable>(_ endpoint: Endpoints, method: HTTPMethods ,completion: @escaping (Result<T, Error>) -> Void)
}

public final class NetworkService {
    public static let `default` = NetworkService()
    
    private init() {}
    
    func getNews(for queryString: String, completion: @escaping (Result<NewResponse, Error>) -> Void) {
        if BuildConfig.isRunningTests() || BuildConfig.loadFromLocalJson {
            fetchLocalJson(fileName: "Fashion", completion: completion)
        } else {
            makeRequest(.newsApi(queryString), method: .get , completion: completion)
        }
    }
    
    func getCategories(completion: @escaping (Result<Categories, Error>) -> Void) {
        fetchLocalJson(fileName: "category", completion: completion)
    }
}

extension NetworkService: NetworkServiceProtocol {
    func makeRequest<T: Decodable>(_ endpoint: Endpoints, method: HTTPMethods, completion: @escaping (Result<T, Error>) -> Void) {
        
        var urlRequest = URLRequest(url: endpoint.url)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = headers
        
        let dataTask = URLSession.shared.dataTask(with: urlRequest) { data, response, _ in
            
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(APIError.unknown))
                return
            }
            
            guard let data = data else {
                completion(.failure(APIError.general(error: response.statusCode)))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(T.self, from: data)
                completion(.success(result))
            } catch(let error) {
                completion(.failure(APIError.decodeError(error: error)))
            }
        }
        dataTask.resume()
    }
    
    func fetchLocalJson<T: Decodable>(fileName: String, completion: @escaping (Result<T, Error>) -> Void) {
            if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
                do {
                    let data = try Data(contentsOf: url)
                    let decoder = JSONDecoder()
                    let jsonData = try decoder.decode(T.self, from: data)
                    completion(.success(jsonData))
                } catch {
                    print("error:\(error)")
                    completion(.failure(APIError.decodeError(error: error)))
                }
            }
        }
}
