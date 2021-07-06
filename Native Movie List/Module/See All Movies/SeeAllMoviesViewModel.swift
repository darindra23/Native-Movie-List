//
//  SeeAllMoviesViewModel.swift
//  Native Movie List
//
//  Created by Darindra R on 05/07/21.
//

import Foundation

class SeeAllMoviesViewModel {
    private let service: APIManager!
    var data: MovieResponse?

    var pages = 1

    init(service: APIManager = APIManager.shared) {
        self.service = service
    }
}

extension SeeAllMoviesViewModel {
    func fetch(from endpoint: Endpoint, page: Int, completion: @escaping () -> ()) {
        service.fetchMovies(from: endpoint, page: page) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.data = response
                completion()
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }
}
