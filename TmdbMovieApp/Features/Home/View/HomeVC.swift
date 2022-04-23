//
//  HomeVC.swift
//  TmdbMovieApp
//
//  Created by Hamit Seyrek on 23.04.2022.
//

import UIKit
import RxSwift

enum CellKeys: String {
  case nibName = "MovieCell"
  case reuseIdentifier = "Cell"
}

class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activity: UIActivityIndicatorView!
    
    private var viewModel = HomeViewModel()
    
    private var disposeBag = DisposeBag()
    private var movies = [Movie]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("buradayım")
        tableView.dataSource = self
        tableView.delegate = self
        configureVC()
        displayMovies()

        // Do any additional setup after loading the view.
    }

}

extension HomeVC {
  private func configureVC() {
    configureBindings()
    configureNavBar()
    configureTableView()
  }
    
    private func configureNavBar() {
      navigationItem.title = "Home"
    }

    private func configureTableView() {
      let nibName = CellKeys.nibName.rawValue
      let reuseIdentifier = CellKeys.reuseIdentifier.rawValue
      tableView.rowHeight = UITableView.automaticDimension
      tableView.register(UINib(nibName: nibName, bundle: Bundle.main), forCellReuseIdentifier: reuseIdentifier)
    }

    private func configureBindings() {
      //*****444 viewModel.bind(view: self, router: router)
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
}

extension HomeVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
    return movies.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cellIdentifier: String = CellKeys.reuseIdentifier.rawValue
    guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? MovieCell else {
      fatalError("Error dequing cell: \(cellIdentifier)")
    }
    var movie = movies[indexPath.row]
      cell.movie = movie
    return cell
  }
}

extension HomeVC: UITableViewDelegate {
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 146
  }

  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    var movie = movies[indexPath.row]
      // do something
  }
}

extension HomeVC {
  private func updateTableView() {
    DispatchQueue.main.async { [weak self] in
      self?.tableView.reloadData()
      self?.activity.stopAnimating()
      self?.activity.isHidden = true
    }
  }
}
