//
//  ViewController.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import UIKit

class MainController: UIViewController {
    
    //MARK: Properties
    var moviesCollectionView: MoviesCollectionView!
    
    //TODO: how to avoid this?
    let layout = UICollectionViewFlowLayout()
    
    //MARK: Methods
    override func loadView() {
        moviesCollectionView = MoviesCollectionView(frame: .zero, collectionViewLayout: layout)
        self.view = moviesCollectionView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

}

