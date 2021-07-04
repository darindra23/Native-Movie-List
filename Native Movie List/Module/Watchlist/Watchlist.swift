//
//  FavouriteViewController.swift
//  Native Movie List
//
//  Created by Darindra R on 27/05/21.
//

import UIKit

class Watchlist: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

fileprivate extension Watchlist {
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoviesReusableCell.nib(), forCellReuseIdentifier: MoviesReusableCell.identifier)
    }
}

extension Watchlist: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesReusableCell.identifier, for: indexPath)
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100.0
    }
}
