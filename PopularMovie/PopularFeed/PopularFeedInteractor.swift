//
//  PopularFeedInteractor.swift
//  PopularMovie
//
//  Created by Mihaela Glavan on 27/11/2019.
//  Copyright © 2019 Mihaela Glavan. All rights reserved.
//

import Foundation

protocol PopularFeedInteractorType {
    func fetchNumberOfResults(page: Int, completion: @escaping (DecodeResults) -> ())
    func fetchImages(posterPath: String, completion: @escaping (Data) -> () )
}

class PopularFeedInteractor: PopularFeedInteractorType {
    
    func fetchNumberOfResults(page: Int, completion: @escaping (DecodeResults) -> ()) {
        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=b105c8881b639900674056a95e6487b3&page=\(page)") else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
            if let decoder = try? JSONDecoder().decode(DecodeResults.self, from: data) {
                completion(decoder)
            }
        }.resume()
    }
    
    func fetchImages(posterPath: String, completion: @escaping (Data) -> ()) {
        guard let url = URL(string: "http://image.tmdb.org/t/p/w\(200)\(posterPath)" ) else {
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data, error == nil else {
                return
            }
            
           completion(data)
            }.resume()
    }
    
    
}
