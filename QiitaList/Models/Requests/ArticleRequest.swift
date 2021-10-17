//
//  ArticleRequest.swift
//  QiitaList
//
//  Created by 神山賢太郎 on 2021/10/17.
//

import Foundation
import Combine

//  MARK: - Request
class ArticleRequest: ArticleProtcol {
    
    private let scheme = "https"
    private let host = "qiita.com"
    private let basePath = "/api/v2"
    
    func fetch() -> AnyPublisher<[Article], Error> {
        guard let url = fetchApi().url else {
            let error = RequestError.parse(description: "wrong request url")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .map({ $0.data })
            .decode(type: [Article].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func search(tag: String) -> AnyPublisher<[Article], Error> {
        guard let url = searchApi(tag: tag).url else {
            let error = RequestError.parse(description: "wrong request url")
            return Fail(error: error).eraseToAnyPublisher()
        }
        
        return URLSession.shared
            .dataTaskPublisher(for: URLRequest(url: url))
            .map({ $0.data })
            .decode(type: [Article].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    
    
}

//  MARK: - API
extension ArticleRequest {

    func fetchApi() -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = basePath + "/items"
        return components
    }
    
    func searchApi(tag: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = basePath + "/items"
        components.queryItems = [
            URLQueryItem(name: "per_page", value: "50"),
            URLQueryItem(name: "query", value: "tag:\(tag)")
        ]
        return components
    }
    
}
