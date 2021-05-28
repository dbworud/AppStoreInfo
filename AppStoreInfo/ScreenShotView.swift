//
//  ScreenShotView.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import UIKit

import RxCocoa
import RxSwift
import SnapKit

class ScreenshotView: UIView {
    
    // MARK: - Properties
    private var disposeBag = DisposeBag()

    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout.init())
    let layout = UICollectionViewFlowLayout.init()
    
    /// Screenshot Data
    var screenShotURLPaths = PublishSubject<[String]>()
    
    // MARK: - Init
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
        
        screenShotURLPaths
            .bind(to: collectionView.rx.items) { collectionView, row, element in
            let indexPath = IndexPath(row: row, section: 0)
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ScreenShotCell.identifier,
                                                          for: indexPath) as! ScreenShotCell
            cell.screenShotImageURL = element
            return cell
        }
        .disposed(by: disposeBag)
        
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 230, height: 450)
        
        layout.sectionInset.left = 24
        layout.sectionInset.right = 24
        
        collectionView.setCollectionViewLayout(layout, animated: true)
        collectionView.register(ScreenShotCell.self, forCellWithReuseIdentifier: ScreenShotCell.identifier)
        collectionView.backgroundColor = .white
        collectionView.isPagingEnabled = false
    }
    
    func setupView() {
        addSubview(collectionView)
        
        collectionView.rx.didEndDragging
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                
                let position = self.collectionView.contentOffset.x // 위치의 x값 추출
                
                guard Int(position) != 0 else { return }
                let index = Int(position + 104) / 208
                
                UIView.animate(withDuration: 0.2) {
                    self.collectionView.setContentOffset(CGPoint(x: 208 * index, y: 0), animated: false)
                }
            })
            .disposed(by: disposeBag)
        
        collectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        
        collectionView.rx.didEndDecelerating
            .subscribe(onNext: { [weak self] _ in
                guard let `self` = self else { return }
                
                let position = self.collectionView.contentOffset.x
                
                guard Int(position) != 0 else { return } /// 0이 아닌 경우에만
                let index = Int(position + 104) / 208
                
                UIView.animate(withDuration: 0.2) {
                    self.collectionView.setContentOffset(CGPoint(x: 208 * index, y: 0), animated: false)
                }
            })
            .disposed(by: disposeBag)
    }
    
    func setupLayout() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
