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
        tabBar.tintColor = .primary
        setViewControllers([setupMoviesTabBarItem(), setupWatchlistTabBarItem()], animated: false)
    }

    func setupMoviesTabBarItem() -> UINavigationController {
        let movieVC = MoviesViewController(nibName: "Movies", bundle: nil)
        let movieNavVC = UINavigationController(rootViewController: movieVC)

        movieNavVC.navigationBar.prefersLargeTitles = true
        movieNavVC.tabBarItem = UITabBarItem(title: "Movies", image: UIImage(systemName: "film"), tag: 0)
        movieVC.navigationItem.title = "Movies"

        return movieNavVC
    }

    func setupWatchlistTabBarItem() -> UINavigationController {
        let WatchlistVC = Watchlist(nibName: "Watchlist", bundle: nil)
        let WatchlistNavVC = UINavigationController(rootViewController: WatchlistVC)

        WatchlistNavVC.tabBarItem = UITabBarItem(title: "Watch List", image: UIImage(systemName: "list.and.film"), tag: 1)
        WatchlistNavVC.navigationBar.prefersLargeTitles = true
        WatchlistVC.navigationItem.title = "Watch List"

        return WatchlistNavVC
    }
}
