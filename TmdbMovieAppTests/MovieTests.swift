//
//  MovieTests.swift
//  TmdbMovieAppTests
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import XCTest
@testable import TmdbMovieApp

class MovieTests: XCTestCase {
    
    func testExample() throws {
        
        let bundle = Bundle(for: MovieTests.self)
        guard let url = bundle.url(forResource: "movie", withExtension: "json") else { return }
        let data = try Data(contentsOf: url)
        
        let decoder = Decoders.releaseDateDecoder
        let movie = try decoder.decode(Movie.self, from: data)
        
        XCTAssertEqual(movie.id, 313297)
        XCTAssertEqual(movie.overview, "In the epic fantasy, scruffy, kindhearted Kubo ekes out a humble living while devotedly caring for his mother in their sleepy shoreside village. It is a quiet existence – until a spirit from the past catches up with him to enforce an age-old vendetta. Suddenly on the run from gods and monsters, Kubo’s chance for survival rests on finding the magical suit of armor once worn by his fallen father, the greatest samurai the world has ever known. Summoning courage, Kubo embarks on a thrilling odyssey as he faces his family’s history, navigates the elements, and bravely fights for the earth and the stars.")
        XCTAssertEqual(movie.title, "Kubo and the Two Strings")
        XCTAssertEqual(movie.posterPath, "/3Kr9CIIMcXTPlm6cdZ9y3QTe4Y7.jpg")
    }  
}
