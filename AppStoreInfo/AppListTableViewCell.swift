//
//  AppListTableViewCell.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import Foundation
import SDWebImage
import SnapKit

class AppListTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    fileprivate struct Metric {
        static let appIconImageViewLeft = 16.0
        static let appIconImageViewSize = 50.0
        static let titleLabelLeft = 16.0
        static let titleLabelTop = 12.0
        static let categoryLabelLeft = 16.0
        static let categoryLabelTop = 8.0
    }
    
    var appIconImageView = UIImageView()
    var titleLabel = UILabel()
    var categoryLabel = UILabel()
    
    /// 초기화
    var appData: AppData.Feed.Results? {
        didSet {
            titleLabel.text = appData?.name
            categoryLabel.text = appData?.genres.first?.name
            appIconImageView.sd_setImage(with: URL(string: appData!.artworkUrl100))
        }
    }
    
    // MARK: - Life Cycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupLayout()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        appIconImageView.layer.cornerRadius = 7
        appIconImageView.layer.masksToBounds = true
        appIconImageView.layer.borderWidth = 0.5
        appIconImageView.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        [appIconImageView, titleLabel, categoryLabel].forEach {
            self.contentView.addSubview($0)
        }
    }
    
    func setupLayout() {
        
        appIconImageView.snp.makeConstraints {
            $0.size.equalTo(CGSize(width: Metric.appIconImageViewSize, height: Metric.appIconImageViewSize))
            $0.left.equalTo(self.contentView).offset(Metric.appIconImageViewLeft)
            $0.centerY.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.left.equalTo(appIconImageView.snp.right).offset(Metric.appIconImageViewLeft)
            $0.top.equalToSuperview().offset(Metric.titleLabelTop)
        }
        
        categoryLabel.snp.makeConstraints {
            $0.left.equalTo(appIconImageView.snp.right).offset(Metric.appIconImageViewLeft)
            $0.top.equalTo(titleLabel.snp.bottom).offset(Metric.categoryLabelTop)
        }
    }
}



