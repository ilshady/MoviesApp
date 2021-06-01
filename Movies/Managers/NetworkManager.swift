//
//  NetworkManager.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import Foundation

enum FetchResult {
    case success(movies: [MoviesModel])
    case failure(error: Error)
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
    let dataCache = NSCache<AnyObject, AnyObject>()

    private init() {}
    
    func request(urlString: String, completion: @escaping (FetchResult) -> Void) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            session.dataTask(with: url) { (data, urlResponse, error) in
                
                var result: FetchResult = .success(movies: [])
                
                defer {
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
                
                if error != nil {
                    result = .failure(error: error!)
                }
                
                if let movieData = data {
                    let decoder = JSONDecoder()
                    var moviesToReturn = [MoviesModel]()
                    
                    do {
                        let decodedData = try decoder.decode(MainModel.self, from: movieData)
                        let results = decodedData.results
                        
                        results.forEach({
                            let movie = MoviesModel(title: $0.title, releaseDate: $0.releaseDate, imageURL: $0.imageURL, overview: $0.overview, rating: $0.rating)
                            moviesToReturn.append(movie)

                        })
                        
                    }
                    catch let err {
                        print("Decoding err",err)
                    }
                    
                    result = .success(movies: moviesToReturn)
                }
                
               
                
            }.resume()
        }
    }
}
