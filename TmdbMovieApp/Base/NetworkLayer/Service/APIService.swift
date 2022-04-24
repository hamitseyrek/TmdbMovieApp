//
//  APIService.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import Foundation
import RxSwift

class ApiService {
    
    // Create Observable objects
    
    func getUpcomingMovies(page: Int) -> Observable<Movies> {
        
        let path = "\(Constants.URL.upcomingUrl)?api_key=\(APIKey.key)&page=\(page)"
        
        return Observable.create { observer in
            NetworkRequest.makeNetworkRequest(path: path) { (completion: Result<Movies, NetworkError>) in
                switch completion {
                case .success(data: let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func getNowPlayingMovies(page: Int) -> Observable<Movies> {
        
        let path = "\(Constants.URL.nowPlayingUrl)?api_key=\(APIKey.key)&page=\(page)"
        
        return Observable.create { observer in
            NetworkRequest.makeNetworkRequest(path: path) { (completion: Result<Movies, NetworkError>) in
                switch completion {
                case .success(data: let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
    
    func getMovieDetail(movieID: Int) -> Observable<MovieDetail> {
        
        let path = "\(Constants.URL.detailUrl)\(movieID)?api_key=\(APIKey.key)"
        
        return Observable.create { observer in
            NetworkRequest.makeNetworkRequest(path: path) { (completion: Result<MovieDetail, NetworkError>) in
                switch completion {
                case .success(data: let data):
                    observer.onNext(data)
                case .failure(let error):
                    observer.onError(error)
                }
            }
            return Disposables.create()
        }
    }
}
