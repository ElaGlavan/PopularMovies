//
//  DecodeResults.swift
//  PopularMovie
//
//  Created by Mihaela Glavan on 27/11/2019.
//  Copyright © 2019 Mihaela Glavan. All rights reserved.
//

import Foundation

struct DecodeResults: Decodable {
    var results: [PopularMovies]
}

struct PopularMovies: Decodable {
    var poster_path: String
}

extension DecodeResults: Equatable {
    
    public static func ==(lhs: DecodeResults, rhs: DecodeResults) -> Bool {
        return lhs.results == rhs.results
    }
    
}


extension PopularMovies: Equatable {
    
    public static func ==(lhs: PopularMovies, rhs: PopularMovies) -> Bool {
        return lhs.poster_path == rhs.poster_path
    }

}
