//
//  Router.swift
//  PopularMovie
//
//  Created by Mihaela Glavan on 27/11/2019.
//  Copyright © 2019 Mihaela Glavan. All rights reserved.
//

import Foundation
import UIKit

protocol RouterType {
    func navigateToFeed()
}

class Router: RouterType {
    var storyboard: UIStoryboard
    var popularFeedNavigationController: UINavigationController
    
    init(storyboard: UIStoryboard, popularFeedNavigationController: UINavigationController) {
        self.storyboard = storyboard
        self.popularFeedNavigationController = popularFeedNavigationController
    }

    func navigateToFeed() {
        let viewController = storyboard.instantiateViewController(withIdentifier: "PopularFeedViewController") as! PopularFeedViewController
        let interactor = PopularFeedInteractor()
        let presenter = PopularFeedPresenter(view: viewController, interactor: interactor, router: self)
        viewController.presenter = presenter
        popularFeedNavigationController.setViewControllers([viewController], animated: false)
    }
}
