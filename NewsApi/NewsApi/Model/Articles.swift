//
//  Articles.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/21/22.
//

import Foundation

struct ArticleList : Decodable {
    var results : [Articles]
}

struct Articles : Decodable {
    var title : String
    var abstract : String
    var multimedia : [Multimedia]
}

struct Multimedia: Decodable {
    var url : String
}
