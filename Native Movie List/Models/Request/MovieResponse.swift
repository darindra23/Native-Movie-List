//
//  Movies.swift
//  Native Movie List
//
//  Created by Darindra R on 02/07/21.
//

import Foundation

struct MovieResponse: Codable {
    let page: Int
    var data: [Movie]
    let totalPage: Int

    enum CodingKeys: String, CodingKey {
        case page
        case data = "results"
        case totalPage = "total_pages"
    }
}

struct VideoResponse: Codable {
    let results: [Video]?
}

struct Movie: Codable {
    let id: Int?
    let title: String?
    let overview: String?
    let posterPath: String?
    let backdropPath: String?
    let releaseDate: String?
    let voteAverage: Double?
    let genres: [Genres]?
    let status: String?
    let popularity: Double?
    let language: String?
    let runtime: Int?
    let reviews: Int?
    let budget: Int?
    let revenue: Int?
    let languages: [Language]?
    let countries: [Countries]?
    let videos: VideoResponse?

    enum CodingKeys: String, CodingKey {
        case id
        case title
        case overview
        case genres
        case status
        case popularity
        case runtime
        case budget
        case revenue
        case videos
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case language = "original_language"
        case reviews = "vote_count"
        case languages = "spoken_languages"
        case countries = "production_countries"
    }

    var backdrop: URL {
        URL(string: "https://image.tmdb.org/t/p/w500\(backdropPath ?? "")")!
    }

    var backdropOriginal: URL {
        URL(string: "https://image.tmdb.org/t/p/original\(backdropPath ?? "")")!
    }

    var poster: URL {
        URL(string: "https://image.tmdb.org/t/p/w500\(posterPath ?? "")")!
    }
}

struct Video: Codable {
    let id: String?
    let key: String?
    let name: String?
    let site: String?
    let size: Int?
    let type: String?
}

struct Genres: Codable {
    let name: String
}

struct Language: Codable {
    let name: String

    enum CodingKeys: String, CodingKey {
        case name = "english_name"
    }
}

struct Countries: Codable {
    let iso: String
    let name: String

    enum CodingKeys: String, CodingKey {
        case name
        case iso = "iso_3166_1"
    }
}


