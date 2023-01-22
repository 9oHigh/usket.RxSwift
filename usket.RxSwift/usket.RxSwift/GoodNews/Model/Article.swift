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

extension ArticleList {
    static var all: Resource<ArticleList> = {
        let url = URL(string: "https://newsapi.org/v2/everything?q=tesla&from=2022-12-22&sortBy=publishedAt&apiKey=f9dc43ce33ae4fe09478fabcab42d82b")!
        return Resource(url: url)
    }()
}

struct Article: Decodable {
    let title: String
    let description: String
}
