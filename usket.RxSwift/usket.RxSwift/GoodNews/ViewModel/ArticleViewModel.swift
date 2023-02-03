//
//  ArticleViewModel.swift
//  usket.RxSwift
//
//  Created by 이경후 on 2023/02/03.
//

import Foundation
import RxSwift
import RxCocoa

struct ArticleListViewModel {
    
    let articlesVM: [ArticleViewModel]
    
}
extension ArticleListViewModel {
    
    init(_ articles: [Article]){
        self.articlesVM = articles.compactMap(ArticleViewModel.init)
    }
    
    func articleAt(_ index: Int) -> ArticleViewModel {
        return self.articlesVM[index]
    }
}

struct ArticleViewModel {
    
    let article: Article
    
    init(_ article: Article) {
        self.article = article
    }
}
extension ArticleViewModel {
    
    var title: Observable<String> {
        return Observable<String>.just(article.title)
    }
    
    var description: Observable<String> {
        return Observable<String>.just(article.description)
    }
    
}
