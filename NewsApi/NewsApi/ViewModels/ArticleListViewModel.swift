//
//  ArticleListViewModel.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/21/22.
//

import Foundation

// MARK: ArticleListViewModel

struct ArticleListViewModel {
    let articles : [Articles]
}

extension ArticleListViewModel {
    var numberOfSection : Int {
        return 1
    }
    
    func numberOfRowInSection(_ section : Int) -> Int {
        return self.articles.count
    }
    
    func articleAtIndex(_ index : Int) -> ArticleViewModel {
        let article = self.articles[index]
        return ArticleViewModel(article)
    }
    
    func numberOfItemsInSection(_ section : Int) -> Int {
        return self.articles.count
    }
}


// MARK: ArticleViewModel

struct ArticleViewModel {
    private let article : Articles
}

extension ArticleViewModel {
    init (_ article: Articles) {
        self.article = article
    }
}

extension ArticleViewModel {
    var title : String {
        return self.article.title
    }
    
    var abstract : String {
        return self.article.abstract
    }
    
    var url : String {
        return self.article.multimedia[0].url
    }
}
