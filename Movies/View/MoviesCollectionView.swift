//
//  MoviesCollectionView.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import UIKit

class MoviesCollectionView: UICollectionView {
    
    let cellID = "cellID"
    
    var movieDataSource = [MoviesModel]()
    var movieForDetail: MoviesModel?
    
    var moviesCVDelegate: MoviesCollectionViewDelegate?
    
    let urlString = APIURLs.fullPath
    let paginationURL = APIURLs.pagingPath
    var nextPage = 2
    
    let customRefreshControl: UIRefreshControl = {
        let ref = UIRefreshControl()
        ref.addTarget(self, action: #selector(refresh(sender:)), for: .valueChanged)
        return ref
    }()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        delegate = self
        dataSource = self
        register(MovieCell.self, forCellWithReuseIdentifier: cellID)
        refreshControl = customRefreshControl
        
        loadMoreItems(page: "\(1)")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func refresh(sender: UIRefreshControl) {
        movieDataSource.removeFirst()
        DispatchQueue.main.async {
            self.reloadData()
        }
        sender.endRefreshing()
    }
    
    func loadMoreItems(page: String) {
        MoviesNetworkService.shared.request(urlString: paginationURL + page)  { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieDataSource.append(contentsOf: movies)
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func showController(movie: MoviesModel) {
        movieForDetail = movie
        moviesCVDelegate?.cellDidtapped()
    }
}

//MARK: CollectionViewDelegateFlowLayout
extension MoviesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 12, height: collectionView.frame.height/4)
    }
}
//MARK: CollectionViewDataSource
extension MoviesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MovieCell
        
        let movie = movieDataSource[indexPath.row]
        cell.titleView.text = movie.title
        cell.releaseDateView.text = movie.releaseDate
        cell.ratingView.text = "\(movie.voteAverage)"
        cell.bgImageView.downloaded(from: APIURLs.imageBaseURL + movie.backdropPath)
        
        if indexPath.row == movieDataSource.count - 1 {
            loadMoreItems(page: "\(nextPage)")
            nextPage += 1
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let movie = movieDataSource[indexPath.row]
        showController(movie: movie)
    }
    
}

