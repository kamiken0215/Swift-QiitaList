//
//  Errors.swift
//  QiitaList
//
//  Created by 神山賢太郎 on 2021/10/17.
//

import Foundation

enum RequestError: Error {
    case parse(description: String)
    case network(description: String)
}
