//
//  Webservices.swift
//  NewsApi
//
//  Created by Somnath Jadhav on 7/21/22.
//

import Foundation

class Webservices {
    
    func getNewsAppData(url: URL, completion: @escaping ([Articles]?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
            } else if let data = data {
               // print(data.count)
                let articleList = try? JSONDecoder().decode(ArticleList.self, from: data)
                if let articleList = articleList {
                    completion(articleList.results)
                }
                //print(articleList?.results)
            }
            
        } .resume()
    }
}
