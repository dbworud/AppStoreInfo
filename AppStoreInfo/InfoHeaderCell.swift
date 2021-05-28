//
//  InfoHeaderCell.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import UIKit
import SnapKit

class InfoHeaderCell: UICollectionViewCell {
    // MARK: - Properties
    var topLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 12)
    }

    var middleLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .boldSystemFont(ofSize: 18)
    }
    
    var bottomLabel = UILabel().then {
        $0.textColor = .lightGray
        $0.font = .systemFont(ofSize: 15)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        [topLabel, middleLabel, bottomLabel].forEach {
            contentView.addSubview($0)
        }
    }
    
    func setupLayout() {
        topLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(5)
            $0.centerX.equalToSuperview()
            //$0.left.equalTo(self.contentView.snp.left).offset(10)
        }
        
        middleLabel.snp.makeConstraints {
            $0.top.equalTo(topLabel.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
            //$0.left.equalTo(self.contentView.snp.left).offset(10)
        }
        
        bottomLabel.snp.makeConstraints {
            $0.top.equalTo(middleLabel.snp.bottom).offset(5)
            $0.centerX.equalToSuperview()
            //$0.left.equalTo(self.contentView.snp.left).offset(10)
        }
    }

}
