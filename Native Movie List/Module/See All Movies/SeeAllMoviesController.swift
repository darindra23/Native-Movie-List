//
//  SeeAllMoviesController.swift
//  Native Movie List
//
//  Created by Darindra R on 28/06/21.
//

import UIKit

class SeeAllMoviesController: UITableViewController {

    static let identifier = "SeeAllMoviesController"
    let viewModel = SeeAllMoviesViewModel()

    var endpoint: Endpoint? {
        didSet {
            self.tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.data?.data.count ?? 0
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard let data = viewModel.data else { return }

        if indexPath.row == data.data.count - 1 && viewModel.pages < data.totalPage {
            viewModel.addPages()
            viewModel.fetch(from: endpoint!, page: viewModel.pages) {
                DispatchQueue.main.async { [weak self] in
                    guard let self = self else { return }
                    self.tableView.reloadData()
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MoviesReusableCell.identifier, for: indexPath) as! MoviesReusableCell
        cell.configure(with: viewModel.data?.data[indexPath.row])
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = MovieDetailViewController(nibName: MovieDetailViewController.identifier, bundle: nil)
        vc.movieId = viewModel.data?.data[indexPath.row].id
        navigationController?.pushViewController(vc, animated: true)
    }
}

fileprivate extension SeeAllMoviesController {
    func setup() {
        self.tableView.register(MoviesReusableCell.nib(), forCellReuseIdentifier: MoviesReusableCell.identifier)
    }

    func fetchMovie(page: Int) {
        viewModel.fetch(from: endpoint!, page: page) {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}
