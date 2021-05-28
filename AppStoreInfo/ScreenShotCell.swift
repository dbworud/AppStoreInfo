//
//  ScreenShotCell.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import UIKit
import SDWebImage
import SnapKit

class ScreenShotCell: UICollectionViewCell {
    
    var screenShotImageView = UIImageView()
    
    var screenShotImageURL: String = "" {
        didSet {
            screenShotImageView.sd_setImage(with: URL(string: screenShotImageURL))
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        screenShotImageView.layer.cornerRadius = 20
        screenShotImageView.layer.borderWidth = 0.5
        screenShotImageView.layer.borderColor = UIColor.lightGray.cgColor
        screenShotImageView.layer.masksToBounds = true
    }
    
    func setupView() {
        addSubview(screenShotImageView)
    }
    
    func setupLayout() {
        screenShotImageView.snp.makeConstraints{
            $0.edges.equalToSuperview()
        }
    }
}

