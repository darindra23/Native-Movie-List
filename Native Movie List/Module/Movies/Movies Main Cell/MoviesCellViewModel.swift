//
//  MoviesCellViewModel.swift
//  Native Movie List
//
//  Created by Darindra R on 03/07/21.
//

import Foundation

class MoviesCellViewModel {
    private var service: APIManager!
    private(set) var nowPlayingData: MovieResponse?
    private(set) var popularData: MovieResponse?
    private(set) var upcomingData: MovieResponse?

    let dispatchGroup = DispatchGroup()

    init(service: APIManager = APIManager.shared) {
        self.service = service
    }
}

extension MoviesCellViewModel {
    func fetchAll(completion: @escaping () -> ()) {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            guard let self = self else { return }

            self.fetch(from: .nowPlaying)
            self.fetch(from: .popular)
            self.fetch(from: .upcoming)

            self.dispatchGroup.notify(queue: .main) {
                completion()
            }
        }
    }

    func fetch(from endpoint: Endpoint) {
        self.dispatchGroup.enter()
        service.fetchMovies(from: endpoint, page: 1) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                switch endpoint {
                case .nowPlaying: self.nowPlayingData = response
                case .popular: self.popularData = response
                case .upcoming: self.upcomingData = response
                }
            case .failure(let error): print(error.localizedDescription)
            }

            self.dispatchGroup.leave()
        }
    }
}
