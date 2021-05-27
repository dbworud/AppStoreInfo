//
//  View.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import Foundation
import RxSwift

protocol View {
    associatedtype Reactor
    
    var disposeBag: DisposeBag { get set }
    
    func bind(reactor: Reactor)
}
