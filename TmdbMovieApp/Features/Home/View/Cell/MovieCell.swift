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

extension UIImageView {
    
    func downloaded(from url: URL, contentMode mode: ContentMode = .scaleAspectFit) {
        
        contentMode = mode
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
            else { return }
            DispatchQueue.main.async() { [weak self] in
                self?.image = image
            }
        }.resume()
    }
    func downloaded(from link: String, contentMode mode: ContentMode = .scaleToFill) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
