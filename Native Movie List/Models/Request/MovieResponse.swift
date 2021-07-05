//
//  Movies.swift
//  Native Movie List
//
//  Created by Darindra R on 02/07/21.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    let data: [Movie]
    let totalPage: Int

    enum CodingKeys: String, CodingKey {
        case page
        case data = "results"
        case totalPage = "total_pages"
    }
}

struct Movie: Codable {
    let id: Int
    let title: String
    let overview: String
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String
    let voteAverage: Double

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
    }

    var backdrop: URL {
        URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }

    var poster: URL {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}
