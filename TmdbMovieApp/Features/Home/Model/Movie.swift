//
//  Movie.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import Foundation

struct Movie: Codable {
    
    let id: Int
    let overview, title: String
    let posterPath: String?
    let releaseDate: Date
    let backdropPath: String?
    
    enum CodingKeys : String, CodingKey {
        
        case id
        case overview, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case backdropPath = "backdrop_path"
    }
}

extension Movie: Equatable {
    
    static func == (lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id
    }
}

extension Movie: Hashable {
    
    func hash(into hasher: inout Hasher) {
        hasher.combine (id)
    }
}
