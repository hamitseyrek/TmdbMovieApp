//
//  DetailViewModel.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import Foundation
import RxSwift

class DetailViewModel {
    
    private let apiService = ApiService()
    
    func getMovieDetail(movieID: Int) -> Observable<MovieDetail> {
        return apiService.getMovieDetail(movieID: movieID)
    }
}
