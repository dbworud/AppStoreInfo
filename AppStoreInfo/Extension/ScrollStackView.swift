//
//  ScrollStackView.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/28.
//

import UIKit

class ScrollStackView: UIScrollView {
    
    var containerView = UIView()
    
    let stackView = UIStackView().then {
        $0.alignment = .fill
        $0.distribution = .fill
        $0.axis = .horizontal
        $0.spacing = 0
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }
    
    func addArrangedSubview(_ view: UIView) {
        self.stackView.addArrangedSubview(view)
    }
    
    func setupView() {
        contentInsetAdjustmentBehavior = .always
        
        addSubview(containerView)
        containerView.addSubview(stackView)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
