//
//  ViewController.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import UIKit

protocol MoviesCollectionViewDelegate {
    func cellDidtapped()
}

class MainController: UIViewController {
    
    //MARK: Properties
    private var moviesCollectionView: MoviesCollectionView!
    
    private let layout = UICollectionViewFlowLayout()
    
    //MARK: Methods
    override func loadView() {
        moviesCollectionView = MoviesCollectionView(frame: .zero, collectionViewLayout: layout)
        self.view = moviesCollectionView
        
        moviesCollectionView.moviesCVDelegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}

//MARK: MoviesCollectionViewDelegate
extension MainController: MoviesCollectionViewDelegate {
    func cellDidtapped() {
        let detailsVC = DetailsViewController()
        detailsVC.movie = moviesCollectionView.movieForDetail
        present(detailsVC, animated: true)
    }
    
}
