//
//  DiscoverHeader.swift
//  letsmovie
//
//  Created by Panupong Kukutapan on 14/11/2562 BE.
//  Copyright © 2562 Panupong Kukutapan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DiscoverHeader: UICollectionReusableView, UsableViewModel {
    
    private var horizontalStackView = DiscoverHeader.horizontalStackView()
    var titleLabel = DiscoverHeader.titleLabel()
    var seeAllButton = DiscoverHeader.seeAllButton()
    
    private let padding: CGFloat = 16
    
    private let disposeBag = DisposeBag()
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUIElements()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var viewModel: DiscoverHeaderViewModel!
    var bindedViewModel: ViewModelType!
    func bindViewModel() {
        viewModel = (bindedViewModel as? DiscoverHeaderViewModel)
        
        viewModel.title
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
        
        seeAllButton.rx.action = viewModel.seeAllAction
    }
}

//MARK:- UI Elements
extension DiscoverHeader {
    private func setupUIElements() {
        horizontalStackView.addArrangedSubview(titleLabel)
        horizontalStackView.addArrangedSubview(seeAllButton)
        
        addSubview(horizontalStackView)
        horizontalStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            horizontalStackView.topAnchor.constraint(equalTo: topAnchor),
            horizontalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            horizontalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            horizontalStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    class func titleLabel() -> UILabel {
        let lb = UILabel()
        lb.text = "Title"
        lb.textColor = .label
        lb.font = .boldSystemFont(ofSize: 24)
        return lb
    }
    
    class func seeAllButton() -> UIButton {
        let bt = UIButton(type: .system)
        bt.setTitle("See All", for: .normal)
        bt.setTitleColor(.systemGray, for: .normal)
        bt.titleLabel?.font = .systemFont(ofSize: 16)
        return bt
    }
    
    class func horizontalStackView() -> UIStackView {
        let sv = UIStackView()
        sv.axis = .horizontal
        sv.alignment = .center
        return sv
    }
}
