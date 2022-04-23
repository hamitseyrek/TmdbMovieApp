//
//  HomeVC.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import UIKit
import RxSwift

class HomeVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var sliderTimer: Timer?
    var currentCellIndex = 0
    
    private var viewModel = HomeViewModel()
    
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("buradayım")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CollectionCell")
        sliderCollectionView.contentInsetAdjustmentBehavior = .never

        displayMovies()
        startTimerForSlider()
        
        // Do any additional setup after loading the view.
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
            return .lightContent
        }
}

extension HomeVC {
    
    private func displayMovies() {
        
        return viewModel.getUpcomingMovies()
        // Handle RxSwift concurrency, execute on Main Thread
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        // Subscribe observer to Observable
            .subscribe(
                onNext: { [weak self] movies in
                    self?.movies = movies
                    print("movies in view: \(movies.map { $0.title })")
                    //print("movies in view: \(movies.map { $0.releaseDate.formatted(.iso8601.year()) })")
                    self?.updateTableView()
                }, onError: { error in
                    print("error in view: \(error)")
                    // Finalize the RxSwift sequence (Disposable)
                }, onCompleted: {}).disposed(by: disposeBag)
    }
    
    private func updateTableView() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.tableView.reloadData()
            self?.sliderCollectionView.reloadData()
            
            self?.activity.stopAnimating()
            self?.activity.isHidden = true
        }
    }
    
    func startTimerForSlider() {
        sliderTimer = Timer.scheduledTimer(timeInterval: 2.5, target: self, selector: #selector(moveToNextIndex), userInfo: nil, repeats: true)
    }
    
    @objc func moveToNextIndex() {
        if currentCellIndex < movies.count - 1 {
            currentCellIndex += 1
            sliderCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
        }
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MovieCell else {
            fatalError("Error dequing cell: MovieCell")
        }
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
        // do something
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("***************44444444444")
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Error dequing cell: CollectionCell")
            print("***************5")
        }
        print("***************6")
        let movie = movies[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        print("**********", collectionView.frame.height)
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movies[indexPath.row]
    }
}
