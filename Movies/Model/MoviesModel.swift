//
//  MoviesModel.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import Foundation

struct MainModel: Codable {
    let results: [MoviesModel]
}

struct MoviesModel: Codable {
    
    let title: String
    let releaseDate: String
    let imageURL: String
    let overview: String
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case title
        case releaseDate = "release_date"
        case imageURL = "poster_path"
        case overview
        case rating = "vote_average"
    }
}
