//
//  ArticleProtcol.swift
//  QiitaList
//
//  Created by 神山賢太郎 on 2021/10/17.
//

import Foundation
import Combine

protocol ArticleProtcol {
    func fetch() -> AnyPublisher<[Article], Error>
    func search(tag: String) -> AnyPublisher<[Article], Error>
}
