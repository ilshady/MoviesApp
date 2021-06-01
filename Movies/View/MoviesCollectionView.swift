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
        backgroundColor = .white
        delegate = self
        dataSource = self
        register(MovieCell.self, forCellWithReuseIdentifier: cellID)
        refreshControl = customRefreshControl
        
        NetworkManager.shared.request(urlString: urlString) { [weak self] result in
            switch result {
            case .success(let movies):
                self?.movieDataSource = movies
                DispatchQueue.main.async {
                    self?.reloadData()
                }
            case .failure(let error):
                print(error)
            }
        }
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
        NetworkManager.shared.request(urlString: paginationURL + page)  { [weak self] result in
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
        let detailsVC = DetailsViewController()
        detailsVC.movies = movieDataSource
        //TO DO: SORRY CAN'T FIND OTHER WAY to do this
        let VC = MainController()
        VC.present(detailsVC, animated: true)
        
    }
}

//MARK: CollectionViewDelegateFlowLayout
extension MoviesCollectionView: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width - 12, height: collectionView.frame.height/5)
    }
}
//MARK: CollectionViewDataSource
extension MoviesCollectionView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        movieDataSource.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! MovieCell
        cell.backgroundColor = .green
        
        let movie = movieDataSource[indexPath.row]
        cell.titleView.text = movie.title
        cell.releaseDateView.text = movie.releaseDate
        cell.ratingView.text = "\(movie.rating)"
        cell.bgImageView.downloaded(from: APIURLs.imageBaseURL + movie.imageURL)
        
        if indexPath.row == movieDataSource.count - 1 { // last cell
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

