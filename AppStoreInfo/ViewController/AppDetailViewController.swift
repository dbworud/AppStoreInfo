//
//  AppDetailViewController.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import UIKit

import Moya
import SnapKit
import RxSwift

class AppDetailViewController: BaseViewController {
    
    var appID: String? /// AppListTableViewCell로부터 전달된 앱 아이디 정보
    var appDetailData: [AppDetailData.Results] = []
    
    let scrollView = UIScrollView()
    let contentView = UIView()
    
    let titleLabel = UILabel().then {
        $0.font = .boldSystemFont(ofSize: 25)
    }
    
    let downloadButton = UIButton().then {
        $0.setTitle("받기", for: .normal)
        $0.titleLabel?.font = .boldSystemFont(ofSize: 15)
        $0.setTitleColor(.white, for: .normal)
        $0.backgroundColor = #colorLiteral(red: 0, green: 0.4745098039, blue: 1, alpha: 1)
        $0.contentEdgeInsets = UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 20)
        $0.addTarget(self, action: #selector(downloadDidTap), for: .touchUpInside)
    }
    
    let shareButton = UIButton().then {
        $0.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        $0.addTarget(self, action: #selector(shareDidTap), for: .touchUpInside)
        $0.setTitleColor(#colorLiteral(red: 0, green: 0.4745098039, blue: 1, alpha: 1), for: .normal)
    }
    
    let artistNameLabel = UILabel().then {
        $0.textColor = .lightGray
    }
    let iconImageView = UIImageView()
    
    let horizontalDivider = UIView().then {
        $0.backgroundColor = .lightGray
    }
    
    let infoHeaderView = InfoHeaderView()
    let screenShotView = ScreenshotView()
    
    let versionLabel = UILabel()
    let releaseNoteTextView = UITextView()
    let descriptionTextView = UITextView()
    let artistLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        requestData()
    }
    
    override func viewDidLayoutSubviews() {
        iconImageView.layer.cornerRadius = 20
        iconImageView.layer.borderColor = UIColor.lightGray.cgColor
        iconImageView.layer.masksToBounds = true
        iconImageView.layer.borderWidth = 0.5
        iconImageView.sd_setImage(with: URL(string: appDetailData.first?.artworkUrl100 ?? ""))
        
        downloadButton.layer.cornerRadius = 14
    }
    
    override func setupView() {
        super.setupView()
        self.view.addSubview(scrollView)
        self.scrollView.addSubview(contentView)
        
        [iconImageView, titleLabel, artistNameLabel, downloadButton, shareButton, horizontalDivider, infoHeaderView, screenShotView].forEach {
            self.scrollView.addSubview($0)
        }
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(scrollView) // 가로 고정, 세로 스크롤
        }
        
        iconImageView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.left.equalToSuperview().offset(24)
            $0.width.height.equalTo(120)
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.left.equalTo(iconImageView.snp.right).offset(24)
        }
        
        artistNameLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.left.equalTo(iconImageView.snp.right).offset(24)
        }
        
        downloadButton.snp.makeConstraints {
            $0.bottom.equalTo(iconImageView.snp.bottom)
            $0.left.equalTo(iconImageView.snp.right).offset(24)
        }
        
        shareButton.snp.makeConstraints {
            $0.centerY.equalTo(downloadButton)
            $0.right.equalToSuperview().offset(-8)
        }
        
        horizontalDivider.snp.makeConstraints {
            $0.bottom.equalTo(infoHeaderView.snp.top)
            $0.width.equalTo(infoHeaderView.snp.width)
            $0.height.equalTo(0.5)
        }
        
        infoHeaderView.snp.makeConstraints {
            $0.top.equalTo(iconImageView.snp.bottom).offset(12)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(100)
        }

        screenShotView.snp.makeConstraints{
            $0.top.equalTo(infoHeaderView.snp.bottom).offset(8)
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(450)
        }
    }
    
    @objc func downloadDidTap() {
        /// app download
    }
    
    @objc func shareDidTap() {
        /// app share
    }
}

extension AppDetailViewController {
    private func requestData() {
        guard let appID = appID else { return }
        
        provider.rx.request(.appDetail(appID: appID))
            .subscribe({ [weak self] result in
                guard let `self` = self else { return }
                
                switch result {
                case .success(let response):
                    
                    guard let responseJSON = try? JSONDecoder().decode(AppDetailData.self, from: response.data)
                    else { return }
                    
                    self.appDetailData = responseJSON.results
                    self.updateView()
                    
                case .error:
                    print("Failure")
                }
            })
            .disposed(by: disposeBag)
    }
    
    private func updateView() {
        titleLabel.text = appDetailData.first?.title
        artistNameLabel.text = appDetailData.first?.artistName
        descriptionTextView.text = appDetailData.first?.description
        
        screenShotView.screenShotURLPaths
            .onNext(appDetailData.first?.screenshotUrls ?? [])
        
        infoHeaderView.setupData(appDetailData: appDetailData)
        
    }
}
