//
//  NetworkRequest.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import Foundation

enum NetworkRequest {
    
    static func makeNetworkRequest<T: Decodable>(path: String, completion: @escaping (Result<T,NetworkError>) -> Void) {
        
        let urlString = "\(path)"
        guard let url = URL(string: urlString) else { return completion(.failure(.invalidEndpoint)) }
        
        print("URL to fetch from: \(url)")
        
        let session = URLSession.shared
        
        session.dataTask(with: url) { data, response, error in
            guard error == nil else {
                return completion(.failure(.apiError))
            }
            
            guard let data = data else {
                return completion(.failure(.noData))
            }
            
            guard response != nil else {
                return completion(.failure(.invalidResponse))
            }
            
            do {
                let decoder = Decoders.releaseDateDecoder
                let decodeData = try decoder.decode(T.self, from: data)
                completion(.success(decodeData))
                
            } catch {
                return completion(.failure(.serializationError))
            }
        }.resume()
        session.finishTasksAndInvalidate()
    }
}
