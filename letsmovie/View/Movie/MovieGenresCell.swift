//
//  MovieGenresCell.swift
//  letsmovie
//
//  Created by Panupong Kukutapan on 21/11/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit

class MovieGenresCell: UICollectionViewCell {
    
    let movieGenresController = MovieGenresController()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MovieGenresCell {
    private func setupView() {
        backgroundColor = .white
        
        guard let movieGenresControllerView = movieGenresController.view else { return }
        movieGenresControllerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(movieGenresControllerView)
        NSLayoutConstraint.activate([
            movieGenresControllerView.topAnchor.constraint(equalTo: topAnchor),
            movieGenresControllerView.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieGenresControllerView.trailingAnchor.constraint(equalTo: trailingAnchor),
            movieGenresControllerView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}