//
//  DetailsViewController.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var movie: MoviesModel?
    
    private var mainImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Screen Shot 2021-02-19 at 20.41.40")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let titleLabel: UILabel = {
        let text = UILabel()
        text.text = "Movie title"
        text.backgroundColor = .white
        text.layer.cornerRadius = 3
        text.layer.masksToBounds = true
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let dateLabel: UILabel = {
        let text = UILabel()
        text.text = "DD/MM/YY"
        text.backgroundColor = .white
        text.layer.cornerRadius = 3
        text.layer.masksToBounds = true
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    private let descriptionLabel: UILabel = {
        let text = UILabel()
        text.text = "The mercurial villain Loki resumes his role as the God of Mischief following the events of 'Avengers: Endgame'."
        text.textColor = .white
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        setupValues()
        setupSubviews()
    }
    
    private func setupValues() {
        if let movie = movie {
            mainImage.downloaded(from: APIURLs.imageBaseURL + movie.backdropPath)
            titleLabel.text = movie.title
            dateLabel.text = movie.releaseDate
            descriptionLabel.text = movie.overview
        }
        
    }
    
    private func setupSubviews() {
        
        view.addSubview(mainImage)
        view.addSubview(titleLabel)
        view.addSubview(dateLabel)
        view.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: 300),
            
            titleLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: -60),
            titleLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            titleLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, constant: 10),
            
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            dateLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dateLabel.widthAnchor.constraint(equalToConstant: 100),
            dateLabel.bottomAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: -10),
            
            descriptionLabel.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            descriptionLabel.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor)
        ])
    }
    
}
