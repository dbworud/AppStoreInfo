//
//  BaseViewController.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import UIKit
import RxSwift
import Moya
import ReactorKit
import Then

class BaseViewController: UIViewController {
    
    /// Network Provider
    let provider = MoyaProvider<AppStore>()
    
    /// DisposeBag
    var disposeBag = DisposeBag()
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required convenience init?(coder: NSCoder) {
        self.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupLayout()
    }
    
    func setupView() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.backgroundColor = .white
    }
    
    func setupLayout() {
        
    }
}
