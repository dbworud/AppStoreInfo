//
//  InfoHeaderView.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import UIKit

import SnapKit
import RxSwift
import RxCocoa
import Cosmos

class InfoHeaderView: UIView {
    
    // MARK: - Properties
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout = UICollectionViewFlowLayout.init()
    
    var ageView = InfoHeaderCell()
    //var artistView = InfoHeaderCell()
    
    // scrollView에 InfoHeaderCell 5개 넣기
    // + 세로 divider 4개
    let verticalDivider = UIView().then {
        $0.backgroundColor = .lightGray
    }

    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        self.addSubview(collectionView)
        
        [ageView].forEach {
            self.collectionView.addSubview($0)
        }
    }
    
    func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.top.bottom.right.equalToSuperview()
            $0.left.equalToSuperview().offset(24)
        }
        
        ageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerY.equalToSuperview()
            $0.left.equalTo(self.collectionView.snp.left).offset(20)
        }
        
//        artistView.snp.makeConstraints {
//            $0.top.equalToSuperview().offset(8)
//            $0.centerY.equalToSuperview()
//            $0.left.equalTo(ageView.snp.right).offset(8)
//        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()

        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 100)

        layout.sectionInset.left = 8
        layout.sectionInset.right = 8

        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(InfoHeaderCell.self, forCellWithReuseIdentifier: InfoHeaderCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = false
    }
    
    func setupData(appDetailData: [AppDetailData.Results]) {
        
        ageView.topLabel.text = "연령"
        ageView.middleLabel.text = appDetailData.first?.age
        ageView.bottomLabel.text = "세"
        
//        artistView.topLabel.text = "개발자"
//        artistView.topLabel.text = "개발자"
//        artistView.bottomLabel.text = appDetailData.first?.artistName
    }
}

