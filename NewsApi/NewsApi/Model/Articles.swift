//
//  Articles.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/21/22.
//

import Foundation

struct ArticleList : Decodable {
    let results : [Articles]
}

struct Articles : Decodable {
    let title : String
    let abstract : String
    let multimedia : [Multimedia]
}

struct Multimedia: Decodable {
    let url : String
}
