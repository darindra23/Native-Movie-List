//
//  MoviesCellViewModel.swift
//  Native Movie List
//
//  Created by Darindra R on 03/07/21.
//

import Foundation

class MoviesCellViewModel {
    private var service: APIManager!
    private(set) var data: MovieResponse?

    var isLoading = false
    var error: NSError?
    var reloadData: (() -> Void)?

    init(service: APIManager = APIManager.shared) {
        self.service = service
    }
}

extension MoviesCellViewModel {
    func fetch(from endpoint: Endpoint, page: Int) {
        service.fetchMovies(from: endpoint, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.isLoading = true

            switch result {
            case .success(let response): self.data = response
            case .failure(let error): self.error = error as NSError
            }

            self.reloadData?()
        }
    }
}
