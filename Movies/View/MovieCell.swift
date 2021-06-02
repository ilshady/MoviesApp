//
//  MovieCell.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    let titleView: UILabel = {
        let text = UILabel()
        text.text = "temp text"
        text.font = UIFont.systemFont(ofSize: 24, weight: .heavy)
        text.textColor = .white
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let releaseDateView: UILabel = {
        let text = UILabel()
        text.text = "temp text"
        text.font = UIFont.boldSystemFont(ofSize: 16)
        text.textColor = .white
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let ratingView: UILabel = {
        let text = UILabel()
        text.text = "temp text"
        text.font = UIFont.systemFont(ofSize: 16)
        text.backgroundColor = .white
        text.layer.cornerRadius = 8
        text.layer.masksToBounds = true
        text.textColor = .black
        text.numberOfLines = 0
        text.translatesAutoresizingMaskIntoConstraints = false
        return text
    }()
    
    let bgImageView: UIImageView = {
        let image = UIImageView()
        image.contentMode = .scaleToFill
        image.image = #imageLiteral(resourceName: "Screen Shot 2021-02-19 at 20.41.40")
        image.layer.cornerRadius = 15
        image.layer.masksToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        image.addoverlay(color: .black, alpha: 0.5)
        return image
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCell() {
        backgroundColor = .green
    }
    
    private func setupSubviews() {
        addSubview(bgImageView)
        addSubview(titleView)
        addSubview(releaseDateView)
        addSubview(ratingView)
        
        NSLayoutConstraint.activate([
            
            bgImageView.leftAnchor.constraint(equalTo: leftAnchor),
            bgImageView.rightAnchor.constraint(equalTo: rightAnchor),
            bgImageView.topAnchor.constraint(equalTo: topAnchor),
            bgImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            
            titleView.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleView.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -10),
            
            releaseDateView.centerXAnchor.constraint(equalTo: centerXAnchor),
            releaseDateView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 8),
            releaseDateView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor, constant: -10),
            
            ratingView.leftAnchor.constraint(equalTo: leftAnchor, constant: 8),
            ratingView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            ratingView.widthAnchor.constraint(lessThanOrEqualTo: widthAnchor),
            //            ratingView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}
