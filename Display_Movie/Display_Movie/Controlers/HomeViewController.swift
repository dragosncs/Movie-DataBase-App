//
//  HomeViewController.swift
//  Movie_Database_App
//
//  Created by Neacsu Dragos on 01.08.2022.
//

import UIKit

struct SectionData {
    let title: String
    var movies = [Movie]()
}

class MovieData {
    var popular: SectionData
    var upcoming: SectionData
    var topRated: SectionData
    
    init(
        popular: SectionData = .init(title: "Popular"),
        upcoming: SectionData = .init(title: "Upcoming"),
        topRated: SectionData = .init(title: "Trending")
    ) {
        self.popular = popular
        self.upcoming = upcoming
        self.topRated = topRated
    }
    
    var sections: [SectionData] {
        [popular, upcoming, topRated]
    }
    
    func setPopular(movies: [Movie]) {
        popular.movies = movies
    }
    
    func setUpcoming(movies: [Movie]) {
        upcoming.movies = movies
    }
    
    func setTopRated(movies: [Movie]) {
        topRated.movies = movies
    }
}

enum Sections: Int {
    case Popular = 0
    case Upcoming = 1
    case TopRated = 2
}

class HomeViewController: UIViewController {
    
    @IBOutlet weak var homeFeed: UITableView!
    var movieData = MovieData()
   // let titles = ["Popular Movies", "Upcoming", "Top Rated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeFeed.register(UINib(nibName: "MovieCathegoryCell", bundle: nil), forCellReuseIdentifier: MovieCathegoryCell.identifier)
        view.backgroundColor = .systemBackground
        
        homeFeed.delegate = self
        homeFeed.dataSource = self
        
        loadMovieData()
        
      //  navigationController?.pushViewController(DetailsPageViewController(), animated: true)
        
    }
    
    func loadMovieData() {
        APICaller.shared.getPopularMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieData.setPopular(movies: movies)
                DispatchQueue.main.async {
                    self?.homeFeed.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        APICaller.shared.getUpcomingMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieData.setUpcoming(movies: movies)
                DispatchQueue.main.async {
                    self?.homeFeed.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
        
        APICaller.shared.getTopRatedMovies { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieData.setTopRated(movies: movies)
                DispatchQueue.main.async {
                    self?.homeFeed.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}

//Creating the cells for the movies deplayed in each section

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        movieData.sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection: Int) -> Int {
        1
    } // Creating title rows for sectios
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        movieData.sections[section].title
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieCathegoryCell.identifier, for: indexPath) as? MovieCathegoryCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        let movies = movieData.sections[indexPath.section].movies
        cell.loadMovies(movies: movies)

        return cell
}

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 260
        default:
            return 150
        }
    }
}

extension HomeViewController: MovieCathegoryCellDelegate {
    func movieCathegoryCellDidTapCell(viewModel: DetailsPageModel) {
      DispatchQueue.main.async { [weak self] in
            let vc = DetailsPageViewController()
            vc.configure(with: viewModel)
          self?.navigationController?.pushViewController(vc, animated: true)
        }
    }
}



