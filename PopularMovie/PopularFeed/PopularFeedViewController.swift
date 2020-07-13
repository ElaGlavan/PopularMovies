//
//  PopularFeedViewController.swift
//  PopularMovie
//
//  Created by Mihaela Glavan on 27/11/2019.
//  Copyright © 2019 Mihaela Glavan. All rights reserved.
//

import Foundation
import UIKit

protocol PopularFeedView  {
    var viewModel: PopularFeedViewModel! {get set}
}

class PopularFeedViewController: UIViewController, PopularFeedView {

    @IBOutlet var collectionView: UICollectionView!
    
    var viewModel: PopularFeedViewModel! {
        didSet {
            updateCell(with: viewModel)
        }
    }
    var presenter: PopularFeedPresenterType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib = UINib(nibName: "PopularFeedCollectionViewCell", bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: "PopularFeedCollectionViewCell")
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        presenter.viewDidLoad()
    }
    
    func updateCell(with viewModel: PopularFeedViewModel) {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        
    }
}

extension  PopularFeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let viewModel = viewModel else {
            return 0
        }
        return viewModel.dataForImage?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularFeedCollectionViewCell", for: indexPath) as! PopularFeedCollectionViewCell
      
        cell.updateCell(with: viewModel, indexPath: indexPath)
        
        return cell
    }
}

extension PopularFeedViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width/2 - 5, height: collectionView.bounds.height/3)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.row  == viewModel.posterPath!.count - 2 {
            presenter.collectionViewHasArrivedAtTheBottom()
        }
    }
}
