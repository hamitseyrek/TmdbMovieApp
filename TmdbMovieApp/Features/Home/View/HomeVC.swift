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
    
    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var sliderCollectionView: UICollectionView!
    var sliderTimer: Timer?
    var currentCellIndex = 0
    
    private var viewModel = HomeViewModel()
    
    private var disposeBag = DisposeBag()
    private var upcomingMovies = [Movie]()
    private var nowPlayingMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("buradayım")
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "MovieCell", bundle: Bundle.main), forCellReuseIdentifier: "Cell")
        
        sliderCollectionView.delegate = self
        sliderCollectionView.dataSource = self
        sliderCollectionView.register(UINib(nibName: "MovieCollectionViewCell", bundle: Bundle.main), forCellWithReuseIdentifier: "CollectionCell")
        // for ignore safe area
        sliderCollectionView.contentInsetAdjustmentBehavior = .never

        displayUpcomingMovies()
        displayNowPlayingMovies()
        startTimerForSlider()
        
        pageControl.numberOfPages = 20
        pageControl.currentPage = 0
        // Do any additional setup after loading the view.
    }
}

extension HomeVC {
    
    private func displayUpcomingMovies() {
        
        return viewModel.getUpcomingMovies()
        // Handle RxSwift concurrency, execute on Main Thread
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        // Subscribe observer to Observable
            .subscribe(
                onNext: { [weak self] movies in
                    self?.upcomingMovies = movies
                    print("movies in view: \(movies.map { $0.title })")

                    self?.updateTableAndCollectionView()
                }, onError: { error in
                    print("error in view: \(error)")
                    // Finalize the RxSwift sequence (Disposable)
                }, onCompleted: {}).disposed(by: disposeBag)
    }
    
    private func displayNowPlayingMovies() {
        
        return viewModel.getNowPlayingMovies()
        // Handle RxSwift concurrency, execute on Main Thread
            .subscribe(on: MainScheduler.instance)
            .observe(on: MainScheduler.instance)
        // Subscribe observer to Observable
            .subscribe(
                onNext: { [weak self] movies in
                    self?.nowPlayingMovies = movies
                    print("movies in view: \(movies.map { $0.title })")

                    self?.updateTableAndCollectionView()
                }, onError: { error in
                    print("error in view: \(error)")
                    // Finalize the RxSwift sequence (Disposable)
                }, onCompleted: {}).disposed(by: disposeBag)
    }
    
    private func updateTableAndCollectionView() {
        
        DispatchQueue.main.async { [weak self] in
            
            self?.tableView.reloadData()
            self?.sliderCollectionView.reloadData()
            
            self?.activity.stopAnimating()
            self?.activity.isHidden = true
            
        }
    }
    
    
    // Automatic slide
    func startTimerForSlider() {
        
        DispatchQueue.main.async { [weak self] in
            self?.sliderTimer = Timer.scheduledTimer(timeInterval: 3.5, target: self as Any, selector: #selector(self?.moveToNextIndex), userInfo: nil, repeats: true)
        }
    }
    
    @objc func moveToNextIndex() {
        
        if currentCellIndex < nowPlayingMovies.count - 1 {
            currentCellIndex += 1
            sliderCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentCellIndex
        } else {
            currentCellIndex = 0
            sliderCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .centeredHorizontally, animated: true)
            pageControl.currentPage = currentCellIndex
        }
    }
    
}

extension HomeVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return upcomingMovies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as? MovieCell else {
            fatalError("Error dequing cell: MovieCell")
        }
        let movie = upcomingMovies[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie = upcomingMovies[indexPath.row]
        // do something
    }
}

extension HomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayingMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CollectionCell", for: indexPath) as? MovieCollectionViewCell else {
            fatalError("Error dequing cell: CollectionCell")
        }
        let movie = nowPlayingMovies[indexPath.row]
        cell.movie = movie
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = nowPlayingMovies[indexPath.row]
    }
}
