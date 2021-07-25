//
//  APIManager.swift
//  Native Movie List
//
//  Created by Darindra R on 28/05/21.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    private init() { }
}

extension APIManager: MovieRequest {

    // MARK: Fetch movies collection
    func fetchMovies(from endpoint: Endpoint, page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> ()) {
        guard let url = URL(string: "\(Constants.BASE_URL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.get(url: url, params: ["page": String(page)], completion: completion)
    }

    // MARK: Fetch one movie
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, APIError>) -> ()) {
        guard let url = URL(string: "\(Constants.BASE_URL)/movie/\(id)") else {
            completion(.failure(.invalidEndpoint))
            return
        }
        self.get(url: url, params: ["append_to_response": "videos,credits"], completion: completion)
    }
}

fileprivate extension APIManager {
    func get<T: Codable>(url: URL, params: [String: String]? = nil, completion: @escaping (Result<T, APIError>) -> ()) {
        guard var urlComponent = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndpoint))
            return
        }

        var queryItems = [URLQueryItem(name: "api_key", value: Constants.TMDBApiKey)]

        if let params = params {
            queryItems.append(contentsOf: params.map({ URLQueryItem(name: $0.key, value: $0.value) }))
        }

        urlComponent.queryItems = queryItems

        guard let finalURL = urlComponent.url else {
            completion(.failure(.invalidEndpoint))
            return
        }

        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            if error != nil {
                completion(.failure(.apiError))
                return
            }

            guard let response = response as? HTTPURLResponse, 200..<300 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            guard let value = try? JSONDecoder().decode(T.self, from: data) else {
                completion(.failure(.serializationError))
                return
            }
            completion(.success(value))
        }.resume()
    }
}
