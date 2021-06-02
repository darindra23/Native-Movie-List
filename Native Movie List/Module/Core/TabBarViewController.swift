//
//  RootViewController.swift
//  Native Movie List
//
//  Created by Darindra R on 25/05/21.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

private extension TabBarViewController {
    func setup() {
        let movieVC = MoviesViewController(nibName: "Movies", bundle: nil)
        let movieNavVC = UINavigationController(rootViewController: movieVC)

        movieNavVC.navigationBar.prefersLargeTitles = true
        movieNavVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 0)
        movieVC.navigationItem.title = "Movies"


        let favouriteVC = FavouriteViewController(nibName: "Favourite", bundle: nil)
        let favouriteNavVC = UINavigationController(rootViewController: favouriteVC)

        favouriteNavVC.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 1)
        favouriteNavVC.navigationBar.prefersLargeTitles = true

        setViewControllers([movieNavVC, favouriteNavVC], animated: false)
    }
}
