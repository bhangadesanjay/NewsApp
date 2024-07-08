//
//  NetworkManager.swift
//  iNews
//
//  Created by Sanjay Bhanagade on 06/07/24.
//

import Foundation

/*
 let client = HTTPClient.shared
 let apiKey = "9b629bcedd984434bd4ca246eb557278"
 let source = "techcrunch"
 let articlesResource = Articles.resourceForAllArticles(apiKey: apiKey, source: source)
 */
enum NetworkError: String, Error {
    case clientError
    case serverError
    case noData
    case dataDecodingError
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
            
        case .clientError:
            return "Bad request".localize()
            
        case .serverError:
            return "Server Error"
            
        case .noData:
            return "Unable to decode".localize()
            
        case .dataDecodingError:
            return "Invalid Response".localize()
        }
    }
}

enum HttpMethod {
    case get([URLQueryItem])
    case post(Data?)
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        }
    }
}

struct NetworkResource<T: Codable> {
    let url: URL
    var method: HttpMethod = .get([])
    let modelType: T.Type
}

extension Articles {
    static func urlQueryItemForAllArticles(apiKey: String, page:String) -> NetworkResource<Articles> {
        let queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "sources", value: "techcrunch"),
            URLQueryItem(name: "sortBy", value: "publishedAt"),
            URLQueryItem(name:"pageSize", value: "20"),
            URLQueryItem(name:"page", value: page),
            URLQueryItem(name: "language", value: "en")
        ]
        
        return NetworkResource(url: URL.forAllArticles, method: .get(queryItems), modelType: Articles.self)
    }
}

extension URL {
    static var forTopHeadlinesArticles: URL {
        URL(string: "https://newsapi.org/v2/top-headlines")!
    }
    
    static var forAllArticles: URL {
        URL(string: "https://newsapi.org/v2/everything")!
    }
}

class NetworkManager{
    static let shared = NetworkManager()
    
    func loadArticleData<T: Codable>(_ networkResource: NetworkResource<T>,completion: @escaping (Result<T,NetworkError>) -> ()) {
        
        var request = URLRequest(url: networkResource.url)
        
        switch networkResource.method {
            
        case .get(let queryItems):
            
            if !queryItems.isEmpty {
                var components = URLComponents(url: networkResource.url, resolvingAgainstBaseURL: false)
                
                components?.queryItems = queryItems
                
                guard let url = components?.url else {
                    return
                }
                request = URLRequest(url: url)
            }
            
        
        case .post(_):
            print("No Post")
        }
        
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = ["Content-Type": "application/json"]
        let session = URLSession(configuration: configuration)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let _ = error {
                completion(.failure(.clientError))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noData))
                return
            }
            let encoder = JSONEncoder()
            
            guard let result = try? JSONDecoder().decode(networkResource.modelType, from: data) else {
                print("decode error")
                return
                //throw completion(.failure(.dataDecodingError))
            }
            completion(.success(result))
        }
        
        task.resume()
        
    }
    
}


