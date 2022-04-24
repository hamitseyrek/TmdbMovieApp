//
//  MovieDetail.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import Foundation

struct MovieDetail: Decodable {
    
    let id: Int
    let title, overview: String
    let backdropPath: String?
    let releaseDate: Date
    let voteAverage: Double
    let imdbID: String
    
    enum CodingKeys: String, CodingKey {
        
        case id
        case title, overview
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case imdbID = "imdb_id"
    }
}
