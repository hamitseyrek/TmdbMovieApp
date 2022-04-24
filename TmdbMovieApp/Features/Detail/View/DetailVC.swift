//
//  DetailVC.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 24.04.2022.
//

import UIKit
import RxSwift

class DetailVC: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var movieDetail: MovieDetail?
    var movieID: Int?
    
    private var viewModel = DetailViewModel()
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        displayMovieDetail()
        // Do any additional setup after loading the view.
    }
}

extension DetailVC {
    
    private func displayMovieDetail() {
        
        guard let movieID = movieID else { return }
        
        return viewModel.getMovieDetail(movieID: movieID)
            .subscribe(onNext: { [weak self] movie in
                
                self?.movieDetail = movie
                self?.showMovieData(movie: movie)
                DispatchQueue.main.async {
                    self?.title = "\(movie.title) (\(movie.releaseDate.formatted(.iso8601.year())))"
                    self?.navigationController?.navigationBar.backItem?.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
                }
            }, onError: { error in
                print("Error observer DetailView: \(error)")
            }).disposed(by: disposeBag)
    }
    
    private func showMovieData(movie: MovieDetail) {
        
        guard let movie = self.movieDetail else { return }
        print(movie.imdbID)
        
        if let posterPath = movie.backdropPath {
            let imageUrl = "\(Constants.URL.imageUrl)\(String(describing: posterPath))"
            print("***********selam")
            imageView.downloaded(from: imageUrl)
        }
        else {
            imageView.image =  UIImage(systemName: "rays")
        }
    }
}
