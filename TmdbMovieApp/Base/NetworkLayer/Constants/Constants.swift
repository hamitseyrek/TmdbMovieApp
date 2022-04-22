//
//  Constants.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

struct Constants {
    
    struct URL {
        
        static let upcomingUrl = "https://api.themoviedb.org/3/movie/upcoming/"
        static let nowPlayingUrl = "https://api.themoviedb.org/3/movie/now_playing/"
        static let detailUrl = "https://api.themoviedb.org/3/movie/"
        static let imageUrl = "https://image.tmdb.org/t/p/w200/"
    }
    
    struct Params {
        static let page = "&page="
        static let language = "&language="
    }
}
