//
//  Constants.swift
//  Native Movie List
//
//  Created by Darindra R on 28/05/21.
//

import Foundation

final class Constants {
    static let TMDBApiKey = Bundle.main.infoDictionary?["TMDB_API_KEY"] as? String ?? ""
    static let BASE_URL = "https://api.themoviedb.org/3"
}
