//
//  MainViewController.swift
//  Native Movie List
//
//  Created by Darindra R on 25/05/21.
//

import UIKit

class MoviesViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

fileprivate extension MoviesViewController {
    func setup() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MoviesCell.nib(), forCellReuseIdentifier: MoviesCell.identifier)
    }
}

extension MoviesViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesCell.identifier, for: indexPath) as! MoviesCell
        cell.navigate = { [weak self] viewController in
            self?.navigationController?.pushViewController(viewController, animated: true)
        }
        return cell
    }
}


