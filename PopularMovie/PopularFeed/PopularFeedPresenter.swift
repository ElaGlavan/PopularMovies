//
//  PopularFeedPresenter.swift
//  PopularMovie
//
//  Created by Mihaela Glavan on 27/11/2019.
//  Copyright © 2019 Mihaela Glavan. All rights reserved.
//

import Foundation

protocol PopularFeedPresenterType {
    func viewDidLoad()
    func collectionViewHasArrivedAtTheBottom()
}

class PopularFeedPresenter: PopularFeedPresenterType {
    
    var interactor: PopularFeedInteractorType
    var view: PopularFeedView
    var router: RouterType
    var dataImage = [Data]()
    var results = [PopularMovies]()
    
    init(view: PopularFeedView, interactor: PopularFeedInteractorType, router: RouterType) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
    
    func viewDidLoad() {
        interactor.fetchNumberOfResults(page: 1) { (numberOfResults) in
            self.results = numberOfResults.results
            self.view.viewModel = PopularFeedViewModel(posterPath: self.results, dataForImage: nil, page: 1)
          
            for path in numberOfResults.results {
                self.interactor.fetchImages(posterPath: path.poster_path, completion: { (data) in
                    self.dataImage.append(data)
                    self.view.viewModel = PopularFeedViewModel(posterPath: self.results, dataForImage: self.dataImage, page: 1)
                })
            }
        }
    }
    
    func collectionViewHasArrivedAtTheBottom() {
        interactor.fetchNumberOfResults(page: view.viewModel.page + 1) { (numberOfResults) in
            let currentResults = numberOfResults.results
            self.results = self.results + currentResults
            self.view.viewModel = PopularFeedViewModel(posterPath: self.results, dataForImage: nil, page: self.view.viewModel.page + 1)
            
            for path in numberOfResults.results {
                self.interactor.fetchImages(posterPath: path.poster_path, completion: { (data) in
                     self.dataImage.append(data)
                    self.view.viewModel = PopularFeedViewModel(posterPath: self.results, dataForImage: self.dataImage, page: self.view.viewModel.page + 1)
                })
            }
        }
    }
}
