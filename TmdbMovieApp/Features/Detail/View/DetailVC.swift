//
//  DetailVC.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import UIKit
import RxSwift
import SafariServices

class DetailVC: UIViewController {
    
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var overviewTextView: UITextView!
    
    var movieDetail: MovieDetail?
    var movieID: Int?
    
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        overviewTextView.isEditable = false
        displayMovieDetail()
    }
}

extension DetailVC {
    
    private func displayMovieDetail() {
        
        guard let movieID = movieID else { return }
        
        return viewModel.getMovieDetail(movieID: movieID)
            .subscribe(onNext: { [weak self] movie in
                
                self?.movieDetail = movie
                
                DispatchQueue.main.async {
                    
                    self?.showMovieData()
                    
                    self?.configureNavBar()
                    
                }
            }, onError: { error in
                print("Error observer DetailView: \(error)")
            }).disposed(by: disposeBag)
    }
    
    private func showMovieData() {
        
        guard let movie = self.movieDetail else { return }
        
        if let posterPath = movie.backdropPath {
            let imageUrl = "\(Constants.URL.imageUrl)\(String(describing: posterPath))"
            imageView.downloaded(from: imageUrl)
        }
        else {
            imageView.image =  UIImage(systemName: "rays")
        }
        
        self.overviewTextView.text = movie.overview
        
        let text = "\(movie.title) (\(movie.releaseDate.formatted(.iso8601.year())))"
        self.titleLabel.attributedText = NSMutableAttributedString(attributedString: NSAttributedString(string: text))
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(openWithSafari))
        titleLabel.addGestureRecognizer(tapGesture)
        titleLabel.isUserInteractionEnabled = true
        
        
        self.voteLabel.text = String(movie.voteAverage)
        self.dateLabel.text = MyHelper().formatter.string(from: movie.releaseDate)
    }
    
    @objc func openWithSafari() {
        guard let movieId = movieDetail?.imdbID else { return }
        guard let url = URL(string: "\(Constants.URL.imdbUrl)\(String(describing: movieId))") else { return }
        let svc = SFSafariViewController(url: url)
        present(svc, animated: true, completion: nil)
        
    }
    
    private func configureNavBar() {
        
        guard let movie = self.movieDetail else { return }
        
        self.title = "\(movie.title) (\(movie.releaseDate.formatted(.iso8601.year())))"
        self.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationController?.navigationBar.backItem?.backBarButtonItem?.tintColor = .black
        let attributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15, weight: UIFont.Weight.bold)]
        self.navigationController?.navigationBar.titleTextAttributes = attributes
        
    }
    
   
}
