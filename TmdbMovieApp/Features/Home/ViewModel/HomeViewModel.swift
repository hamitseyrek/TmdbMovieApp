//
//  HomeViewModel.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import Foundation
import RxSwift

class HomeViewModel {
    
    private let apiService = ApiService()
    
    func getUpcomingMovies(page: Int) -> Observable<Movies> {
        return apiService.getUpcomingMovies(page: page)
    }
    
    func getNowPlayingMovies(page: Int) -> Observable<Movies> {
        return apiService.getNowPlayingMovies(page: page)
    }
    
    func getMovieDetail(movieID: Int) -> Observable<Movie> {
        return apiService.getMovieDetail(movieID: movieID)
    }
}
