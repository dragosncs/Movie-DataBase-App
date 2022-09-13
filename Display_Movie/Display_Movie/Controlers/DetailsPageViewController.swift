//
//  DetailsPageViewController.swift
//  Display_Movie
//
//  Created by Neacsu Dragos on 11.08.2022.
//

import UIKit



class DetailsPageViewController: UIViewController {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont (ofSize: 22, weight: .bold)
        label.text = ""
        return label
    }()
    
    private let overviewLabel: UILabel = {
       
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = ""
        return label
    }()
    
    private let favoriteButton: UIButton = {
       
        let button = UIButton()
        let image = UIImage(systemName: "star", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .systemYellow
        
        return button
    }()
    
    private let shareButton: UIButton = {
       
        let button = UIButton()
        let image = UIImage(systemName: "square.and.arrow.up", withConfiguration: UIImage.SymbolConfiguration(pointSize: 30))
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .lightGray
        
        return button
    }()
    
   private let posterView: UIImageView = {
        let poster = UIImageView()
        poster.contentMode = .scaleAspectFit
        poster.translatesAutoresizingMaskIntoConstraints = false
        return poster
    }()
//

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(posterView)
        view.addSubview(titleLabel)
        view.addSubview(overviewLabel)
        view.addSubview(favoriteButton)
        view.addSubview(shareButton)
        
        configureConstraints()
    }
    
    func configureConstraints() {
        
        let titleLabelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -90),
        ]
        
        let posterViewConstraints = [
            posterView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            posterView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            posterView.heightAnchor.constraint(equalToConstant: 300)
        ]

        
        let overviewLabelConstraints = [
            overviewLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 15),
            overviewLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            overviewLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        
        let favoriteButtonConstrains = [
            favoriteButton.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            favoriteButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            favoriteButton.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        let shareButtonConstrains = [
            shareButton.trailingAnchor.constraint(equalTo: favoriteButton.trailingAnchor, constant: -50),
            shareButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
        ]
        
        NSLayoutConstraint.activate(shareButtonConstrains)
        NSLayoutConstraint.activate(titleLabelConstraints)
        NSLayoutConstraint.activate(posterViewConstraints)
        NSLayoutConstraint.activate(overviewLabelConstraints)
        NSLayoutConstraint.activate(favoriteButtonConstrains)
        
    }
   
    func configure( with model: DetailsPageModel ){
        titleLabel.text = model.title
        overviewLabel.text = model.titleOverview
        
        
        guard let path = model.poster_path, let url = URL(string: "https://image.tmdb.org/t/p/original/\(path)") else {
            return
        }
        posterView.sd_setImage(with: url, completed: nil)
    }
}
 
