//
//  ViewController.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 22.04.2022.
//

import UIKit

import RxSwift

class ViewController: UIViewController {
    
    
    private var viewModel = HomeViewModel()
    
    private var disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.getUpcomingMovies()
    }


}

extension ViewController {
  private func getUpcomingMovies() {
      return viewModel.getUpcomingMovies()
      // Handle RxSwift concurrency, execute on Main Thread
      .subscribe(on: MainScheduler.instance)
      .observe(on: MainScheduler.instance)
      // Subscribe observer to Observable
      .subscribe(
        onNext: { movies in
            print("movies in view: \(movies.map { $0.releaseDate.formatted(.iso8601.year()) })")
        }, onError: { error in
          print("error in view: \(error)")
          // Finalize the RxSwift sequence (Disposable)
        }, onCompleted: {}).disposed(by: disposeBag)
  }
}

