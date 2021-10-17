//
//  Article.swift
//  QiitaList
//
//  Created by 神山賢太郎 on 2021/10/17.
//

import Foundation

//  Codable：APIで取得したJSONを好きなデータ型に変換する。
//  Identifiable：リストで表示させるのに必要。
struct Article: Codable, Identifiable {
    let id: String
    let title: String
    let url: String
}
