//
//  MovieDetailViewModel.swift
//  Native Movie List
//
//  Created by Darindra R on 22/07/21.
//

import Foundation

class MovieDetailViewModel {
    private let service: APIManager!
    var data: Movie?

    init(service: APIManager = APIManager.shared) {
        self.service = service
    }

    func fetchDetailMovie(movieId: Int, completion: @escaping () -> ()) {
        service.fetchMovie(id: movieId) { [weak self] (result) in
            guard let self = self else { return }

            switch result {
            case .success(let response):
                self.data = response
                completion()
            case .failure(let error): print(error.localizedDescription)
            }
        }
    }

    func getLanguages() -> String {
        guard let data = self.data else { return "" }

        var result = ""

        for i in 0..<data.languages!.count {
            if i != data.languages!.count - 1 {
                result += "\(data.languages![i].name.capitalizingFirstLetter()), "
            } else {
                result += "\(data.languages![i].name.capitalizingFirstLetter())"
            }
        }

        return result
    }

    func getGenres() -> String {
        guard let data = self.data else { return "" }

        var result = ""

        for i in 0..<data.genres!.count {
            if i != data.genres!.count - 1 {
                result += "\(data.genres![i].name.capitalizingFirstLetter()), "
            } else {
                result += "\(data.genres![i].name.capitalizingFirstLetter())"
            }
        }

        return result
    }

    func getCountries() -> String {
        guard let data = self.data else { return "" }

        var result = ""

        for i in 0..<data.countries!.count {
            if i != data.countries!.count - 1 {
                result += "\(Utils.emojiFlag(country: data.countries![i].iso)) "
                result += "\(data.countries![i].name.capitalizingFirstLetter()), "
            } else {
                result += "\(Utils.emojiFlag(country: data.countries![i].iso)) "
                result += "\(data.countries![i].name.capitalizingFirstLetter())"
            }
        }

        return result
    }

}
