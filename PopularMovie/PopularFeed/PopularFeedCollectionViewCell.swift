//
//  PopularFeedCollectionViewCell.swift
//  PopularMovie
//
//  Created by Mihaela Glavan on 27/11/2019.
//  Copyright © 2019 Mihaela Glavan. All rights reserved.
//

import Foundation
import UIKit

class PopularFeedCollectionViewCell: UICollectionViewCell {
  
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func updateCell(with viewModel: PopularFeedViewModel, indexPath: IndexPath)  {
        if let data = viewModel.dataForImage {
            imageView.image = UIImage(data: data[indexPath.row])
            spinner.stopAnimating()
        } else {
            spinner.startAnimating()
        }
        
    
    }
}
