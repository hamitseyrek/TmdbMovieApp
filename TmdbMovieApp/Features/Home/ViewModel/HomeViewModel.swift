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
    @Published var image: Data?
    
    func getUpcomingMovies() -> Observable<[Movie]> {
        return apiService.getUpcomingMovies()
    }
    
    func getNowPlayingMovies() -> Observable<[Movie]> {
        return apiService.getNowPlayingMovies()
    }
    
    func getMovieDetail(movieID: Int) -> Observable<Movie> {
        return apiService.getMovieDetail(movieID: movieID)
    }
}
