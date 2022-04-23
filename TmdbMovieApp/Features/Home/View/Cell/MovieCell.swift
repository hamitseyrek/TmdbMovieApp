//
//  MovieCell.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import UIKit

class MovieCell: UITableViewCell {
    
    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var owerviewLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    var movie: Movie? {
        didSet {
            configureCell()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}


extension MovieCell {
    
    private func configureCell() {
        
        guard let movie = self.movie else { return }
        
        if let posterPath = movie.posterPath {
            let imageUrl = "\(Constants.URL.imageUrl)\(String(describing: posterPath))"
            movieImageView.downloaded(from: imageUrl)
        }
        else {
            movieImageView.image =  UIImage(systemName: "rays")
        }
        
        titleLabel.text = "\(movie.title) (\(movie.releaseDate.formatted(.iso8601.year())))"
        owerviewLabel.text = movie.overview
        dateLabel.text = MyHelper().formatter.string(from: movie.releaseDate)
    }
}
