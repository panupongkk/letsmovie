//
//  MovieOverviewCell.swift
//  letsmovie
//
//  Created by Panupong Kukutapan on 22/11/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class MovieOverviewCell: UICollectionViewCell, UsableViewModel {
    
    var overviewTitleLabel = MovieOverviewCell.overviewTitleLabel()
    var overviewLabel = MovieOverviewCell.overviewLabel()
    
    private let disposeBag = DisposeBag()
    let padding: UIEdgeInsets = .init(top: 0, left: 12, bottom: 0, right: -12)
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: MovieOverviewViewModel!
    var bindedViewModel: ViewModelType!
    func bindViewModel() {
        viewModel = (bindedViewModel as? MovieOverviewViewModel)
        
        viewModel.overview
            .bind(to: overviewLabel.rx.text)
            .disposed(by: disposeBag)
    }
}

//MARK:- UI Element
extension MovieOverviewCell {
    private func setupView() {
        backgroundColor = .systemBackground
        
        overviewTitleLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overviewTitleLabel)
        NSLayoutConstraint.activate([
            overviewTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            overviewTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left),
            overviewTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.right)
        ])
        
        
        overviewLabel.translatesAutoresizingMaskIntoConstraints = false
        addSubview(overviewLabel)
        NSLayoutConstraint.activate([
            overviewLabel.topAnchor.constraint(equalTo: overviewTitleLabel.bottomAnchor),
            overviewLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left),
            overviewLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: padding.right),
        ])
    }
    
    class func overviewTitleLabel() -> UILabel {
        let lb = UILabel()
        lb.text = "Overview"
        lb.font = .boldSystemFont(ofSize: 20)
        lb.textColor = .label
        return lb
    }
    
    class func overviewLabel() -> UILabel {
        let lb = UILabel()
        lb.font = .systemFont(ofSize: 16)
        lb.numberOfLines = 0
        lb.textColor = .label
        return lb
    }
}
