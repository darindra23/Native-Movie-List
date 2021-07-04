//
//  MovieRequest.swift
//  Native Movie List
//
//  Created by Darindra R on 02/07/21.
//

import Foundation

protocol MovieRequest {
    func fetchMovies(from endpoint: Endpoint, page: Int, completion: @escaping (Result<MovieResponse, APIError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, APIError>) -> ())
}

enum Endpoint: String, CaseIterable {
    case nowPlaying = "now_playing"
    case popular
    case upcoming
}

enum APIError: Error, CustomNSError {
    case apiError
    case invalidEndpoint
    case invalidResponse
    case noData
    case serializationError

    var localizedDescription: String {
        switch self {
        case .apiError: return "Failed to fetch data"
        case .invalidEndpoint: return "Invalid enpoint"
        case .invalidResponse: return "Invalid response"
        case .noData: return "No data"
        case .serializationError: return "Failed to decode data"
        }
    }

    var errorInfo: [String: Any] {
        [NSLocalizedDescriptionKey: localizedDescription]
    }
}
