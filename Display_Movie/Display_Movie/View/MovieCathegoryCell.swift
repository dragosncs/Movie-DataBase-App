//
//  CollectionViewTableCell.swift
//  Display_Movie
//
//  Created by Neacsu Dragos on 03.08.2022.
//

import UIKit

protocol MovieCathegoryCellDelegate: AnyObject {
    
    func movieCathegoryCellDidTapCell (viewModel: DetailsPageModel)

}

class MovieCathegoryCell: UITableViewCell, UICollectionViewDelegate {
    
    @IBOutlet weak var movieCollectionView: UICollectionView!
    
    @IBOutlet weak var titleLabel: UILabel!
    
    weak var delegate: MovieCathegoryCellDelegate?
    
    private var titles: [Movie] = [Movie]()
   
    
    static let identifier = "MovieCathegoryCell"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        movieCollectionView.register(UINib(nibName: "PreviewCell", bundle: .main), forCellWithReuseIdentifier: PreviewCell.identifier)
        movieCollectionView.delegate = self
        movieCollectionView.dataSource = self
    }
    
    func loadMovies(movies: [Movie]) {
        titles = movies
        movieCollectionView.reloadData()
    }
    
    public func configure(with titles: [Movie]) {
        self.titles = titles
        DispatchQueue.main.async { [weak self] in
            self?.movieCollectionView.reloadData()
        }
    }

}

extension MovieCathegoryCell: UICollectionViewDataSource {
    // Creating the  movie cells that will be displayed in the home page
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PreviewCell.identifier, for: indexPath) as? PreviewCell else {
            return UICollectionViewCell()
        }
        
        guard let model = titles[indexPath.row].poster_path else {
            return UICollectionViewCell()
        }
        cell.configure(with: model)
        
        return cell

    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let movie = titles[indexPath.row]
        let viewModel = DetailsPageModel(title: movie.original_title, titleOverview: movie.overview, poster_path: movie.poster_path, id: movie.id)
        delegate?.movieCathegoryCellDidTapCell(viewModel: viewModel)
    }
}

extension MovieCathegoryCell: UICollectionViewDelegateFlowLayout { //Making the cells to have the same hight with the section
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      
        return CGSize(width: 180, height: collectionView.bounds.height)
        
    }
}
    

