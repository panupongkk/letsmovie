//
//  MovieCreditViewModel.swift
//  letsmovie
//
//  Created by Panupong Kukutapan on 24/11/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import Foundation
import RxSwift

class MovieCreditViewModel: ViewModelType {
    
    let name: Observable<String>
    let detail: Observable<NSAttributedString>
    let imagePath: Observable<String>
    let shortName: Observable<String>
    
    private let movieCredit: MovieCredit
    init(movieCredit: MovieCredit) {
        self.movieCredit = movieCredit
   
        self.name = .just(self.movieCredit.name)
        self.detail = .just(self.movieCredit.detail)
        self.imagePath = .just(self.movieCredit.imageUrlString ?? "")
        self.shortName = .just(self.movieCredit.shortName)
    }
}

extension MovieCreditViewModel: CellIdentifier {
    static var cellIdentifier: String {
        return "movieCreditViewModel"
    }

    class func from(movie: Movie, creditType: CreditType) -> [MovieCreditViewModel] {
        switch creditType {
        case .cast:
            return movie.credits.cast
                .map { (cast) -> MovieCreditViewModel in
                    let name = cast.name
                    let imageUrlString = cast.profilePath
                    let detail = NSMutableAttributedString(string: "as ", attributes: [.font: UIFont.systemFont(ofSize: 14), .foregroundColor: UIColor.lightGray])
                    detail.append(NSAttributedString(string: cast.character, attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.darkGray]))
                    let shortName = imageUrlString == nil ? toShortName(name: name) : ""
                    let movieCredit = MovieCredit(name: name, detail: detail, imageUrlString: imageUrlString, shortName: shortName)
                    return MovieCreditViewModel(movieCredit: movieCredit)
                }
            
        case .crew:
            let jobFilter = ["Director"]
            
            return movie.credits.crew
                .filter {jobFilter.contains($0.job)}
                .map { (crew) -> MovieCreditViewModel in
                    let name = crew.name
                    let imageUrlString = crew.profilePath
                    let detail = NSAttributedString(string: crew.job, attributes: [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.darkGray])
                    let shortName = imageUrlString == nil ? toShortName(name: name) : ""
                    let movieCredit = MovieCredit(name: name, detail: detail, imageUrlString: imageUrlString, shortName: shortName)
                    return MovieCreditViewModel(movieCredit: movieCredit)
                }
        }
    }
    
    class private func toShortName(name: String) -> String {
        let names = name.split(separator: " ")
        let firstName = Array(names[0])
        let lastName = Array(names[1])
        return "\(firstName[0])\(lastName[0])"
    }
}
