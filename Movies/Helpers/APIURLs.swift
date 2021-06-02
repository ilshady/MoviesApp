//
//  Api URLs.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import Foundation

struct APIURLs {
    
    static let baseUrl = "https://api.themoviedb.org/"
    static let apiVersion = "3/"
    static let movieSection = "movie/"
    static let nowPlaying = "now_playing?"
    static let apiKeyPath = "api_key="
    static let page = "&page="
    
    static let apiKey = "fc0de9793aaae73e4b61f32b4895f9ab"
    
    static let imageBaseURL = "https://image.tmdb.org/t/p/w500"

    static let fullPath = baseUrl + apiVersion + movieSection + nowPlaying + apiKeyPath + apiKey
    
    static let pagingPath = fullPath + page
}
