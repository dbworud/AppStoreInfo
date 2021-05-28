//
//  Identifiable.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import Foundation
import UIKit

protocol Identifiable {
    static var identifier: String { get }
}

extension Identifiable {
    static var identifier: String {
        return String(describing: self)
    }
}

/// identifier 자동으로 만들어줌
extension UITableViewCell: Identifiable {}
extension UICollectionViewCell: Identifiable {}
extension UIViewController: Identifiable {}
