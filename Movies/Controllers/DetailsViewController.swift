//
//  DetailsViewController.swift
//  Movies
//
//  Created by Ilshat Khairakhun on 31.05.2021.
//

import UIKit

class DetailsViewController: UIViewController {
    
    var movies: [MoviesModel]?
    
    lazy var mainImage: UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "Screen Shot 2021-02-19 at 20.41.40")
        image.contentMode = .scaleAspectFit
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let titleTextField: UITextField = {
        let text = UITextField()
        text.text = "Movie title"
        return text
    }()
    
    let dateTextField: UITextField = {
        let text = UITextField()
        text.text = "DD/MM/YY"
        return text
    }()
    
    let descriptionTextField: UITextField = {
        let text = UITextField()
        text.text = "The mercurial villain Loki resumes his role as the God of Mischief following the events of 'Avengers: Endgame'."
        return text
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
    }
    
    
    func setupSubviews() {
        view.addSubview(mainImage)
        view.addSubview(titleTextField)
        view.addSubview(dateTextField)
        
        NSLayoutConstraint.activate([
            mainImage.topAnchor.constraint(equalTo: view.topAnchor),
            mainImage.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainImage.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainImage.heightAnchor.constraint(equalToConstant: 400),
            
            titleTextField.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: -40),
            titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            titleTextField.widthAnchor.constraint(equalToConstant: 40),
            
            dateTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 8),
            dateTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            dateTextField.widthAnchor.constraint(equalToConstant: 40),
            dateTextField.bottomAnchor.constraint(equalTo: mainImage.bottomAnchor),
            
            descriptionTextField.topAnchor.constraint(equalTo: mainImage.bottomAnchor, constant: 10),
            descriptionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 10),
            descriptionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -10),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 400)
        ])
    }

}
