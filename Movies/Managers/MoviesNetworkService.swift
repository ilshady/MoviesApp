//
//  NetworkManager.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import UIKit

class MoviesNetworkService {
    
    static let shared = MoviesNetworkService()
    
    let dataCache = NSCache<AnyObject, AnyObject>()
    
    private init() {}
    
    func request(urlString: String, completion: @escaping (Result<[MoviesModel], Error>) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: url) { (data, urlResponse, error) in
                
                if error != nil {
                    completion(.failure(error!))
                    
                }
                
                if let movieData = data {
                    let decoder = JSONDecoder()
                    var moviesToReturn = [MoviesModel]()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    do {
                        let decodedData = try decoder.decode(MainModel.self, from: movieData)
                        let results = decodedData.results
                        
                        results.forEach({
                            let movie = MoviesModel(title: $0.title, releaseDate: $0.releaseDate, backdropPath: $0.backdropPath, overview: $0.overview, voteAverage: $0.voteAverage)
                            if let cachedData = self.dataCache.object(forKey: movie.backdropPath as AnyObject) as? MoviesModel {
                                moviesToReturn.append(cachedData)
                            } else {
                                moviesToReturn.append(movie)
                                self.dataCache.setObject(movie as AnyObject, forKey: movie.backdropPath as AnyObject)
                            }
                        })
                        
                    }
                    catch let err {
                        print("Decoding err",err)
                    }
                    
                    completion(.success(moviesToReturn))
                }
                
            }.resume()
        }
    }
}
