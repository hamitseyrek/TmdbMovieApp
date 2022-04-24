//
//  MovieCollectionViewCell.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieOverview: UILabel!
    
    var movie: Movie? {
        didSet {
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}

extension MovieCollectionViewCell {
    
    private func configureCell() {
        
        guard let movie = self.movie else { return }
        
        if let posterPath = movie.backdropPath {
            let imageUrl = "\(Constants.URL.imageUrl)\(String(describing: posterPath))"
            imageView.downloaded(from: imageUrl)
        }
        else {
            imageView.image =  UIImage(systemName: "rays")
        }
        
        movieTitle.text = "\(movie.title) (\(movie.releaseDate.formatted(.iso8601.year())))"
        movieOverview.text = movie.overview
    }
}
