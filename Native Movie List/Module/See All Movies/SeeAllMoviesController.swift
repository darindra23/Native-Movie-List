//
//  SeeAllMoviesController.swift
//  Native Movie List
//
//  Created by Darindra R on 28/06/21.
//

import UIKit

class SeeAllMoviesController: UITableViewController {

    static let identifier = "SeeAllMoviesController"

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

fileprivate extension SeeAllMoviesController {
    func setup() {
        self.navigationItem.largeTitleDisplayMode = .never
    }
}
