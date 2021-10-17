//
//  Request.swift
//  QiitaList
//
//  Created by 神山賢太郎 on 2021/10/17.
//

import Foundation
import Combine

final class Request<A> {
    
    //  @Published: Modelに変更を通知。汎用化のためにジェネリックにしとる。
    @Published var result: Result<A, Error>? = nil
    //  try?: 例外を無視。なければnilを返却
    var value:A? { try? result?.get() }
    let url: URL
    //  APIからの結果をジェネリック型に変換する関数
    let transform: (Data) -> A?
    
    //  @escaping: クロージャが引数として関数に渡され、関数がリターンした後にそのクロージャが呼び出される場合に付与。init()後load関数を呼ぶため必要。
    init(url: URL, transform: @escaping (Data) -> A?) {
        self.url = url
        self.transform = transform
    }
    
    func load() {
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async {
                if let d = data, let v = self.transform(d) {
                    self.result = .success(v)
                } else {
                    self.result = .failure(PhotoLoadingError())
                }
            }
        }.resume()
    }
    
}

//  MARK: - API
extension Request {
    func apiComponents(path: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme
        components.host = host
        components.path = basePath + path
        return components
    }
}
