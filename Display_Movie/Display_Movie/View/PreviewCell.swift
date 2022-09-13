//
//  PreviewCell.swift
//  Display_Movie
//
//  Created by Neacsu Dragos on 04.08.2022.
//

import UIKit
import SDWebImage

class PreviewCell: UICollectionViewCell {
    
//  static let reuseIdentifier = String(describing: PreviewCell.self)
    
    @IBOutlet weak var imageCell: UIImageView!
    
    static let identifier = "PreviewCell"
    
//    private let posterImage: UIImageView = {
//
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleToFill
//        return imageView
//    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
//        contentView.addSubview(imageCell)
//       imageCell.frame = contentView.bounds
    }
    public func configure(with model: String) {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500/\(model)") else {
            return
        }
        imageCell.sd_setImage(with: url, completed: nil)
    }
}

