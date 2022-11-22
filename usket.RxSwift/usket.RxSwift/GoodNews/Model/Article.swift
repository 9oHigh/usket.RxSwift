//
//  Article.swift
//  usket.RxSwift
//
//  Created by Alfred on 2022/11/22.
//

import Foundation

struct ArticleList: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let title: String
    let description: String
}
