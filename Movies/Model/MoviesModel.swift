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
    let backdropPath: String
    let overview: String
    let voteAverage: Double
    
}
