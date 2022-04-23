//
//  MovieCollectionViewCell.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import UIKit

class MovieCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    var movie: Movie? {
        didSet {
            configureCell()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        print("Buraya da geldim*****************")
        print("Buraya da geldim*****************")
        print("Buraya da geldim*****************")
        print("Buraya da geldim*****************")
        print("Buraya da geldim*****************")
        // Initialization code
    }
}

extension MovieCollectionViewCell {
    
    private func configureCell() {
        
        guard let movie = self.movie else { return }
        
        if let posterPath = movie.posterPath {
            let imageUrl = "\(Constants.URL.imageUrl)\(String(describing: posterPath))"
            imageView.downloaded(from: imageUrl)
        }
        else {
            imageView.image =  UIImage(systemName: "rays")
        }
    }
}
