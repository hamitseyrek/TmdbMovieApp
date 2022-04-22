//
//  Movies.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import Foundation

struct Movies: Codable {
    var results: [Movie]
    var totalPage: Int
    
    enum CodingKeys : String, CodingKey {
        case results
        case totalPage = "total_pages"
    }
}

extension Movies: Equatable {
    
    static func == (lhs: MovieList, rhs: MovieList) -> Bool {
        return lhs.results == rhs.results
    }
}
