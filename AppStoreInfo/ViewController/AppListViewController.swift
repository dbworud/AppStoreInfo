//
//  AppListViewController.swift
//  AppStoreInfo
//
//  Created by jaekyung you on 2021/05/27.
//

import UIKit

import SnapKit
import ReactorKit
import RxSwift
import RxCocoa
import RxDataSources
import Moya

class AppListViewController: BaseViewController, View {
    let headerView = UIView().then {
        $0.backgroundColor = .white
    }
    
    let titleLabel = UILabel().then {
        $0.text = "인기차트"
        $0.font = .boldSystemFont(ofSize: 28)
    }
    
    let tableView = UITableView().then {
        $0.rowHeight = 88
        $0.register(AppListTableViewCell.self, forCellReuseIdentifier: AppListTableViewCell.identifier)
    }
    
    var appData: [AppData.Feed.Results] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reactor = AppListViewReactor()
        reactor?.action.onNext(Reactor.Action.updateAppList)
    }
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func setupView() {
        super.setupView()
        
        self.title = "App Store"
        
        [headerView, tableView].forEach {
            self.view.addSubview($0)
        }
        self.headerView.addSubview(titleLabel)
        
    }
    
    override func setupLayout() {
        super.setupLayout()
        
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide.snp.top)
            $0.left.right.equalToSuperview()
            $0.height.equalTo(88)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(16)
        }
        
        tableView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.bottom.equalToSuperview()
        }
    }
    
    func bind(reactor: AppListViewReactor) {
        // Action
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                guard let `self` = self else { return }

                self.tableView.deselectRow(at: indexPath, animated: false)
                let row = indexPath.row
                let destination = AppDetailViewController()
                destination.appID = self.reactor?.currentState.appList[row].id
                self.navigationController?.pushViewController(destination, animated: false)
            })
            .disposed(by: disposeBag)
        
        // State
        reactor.state
            .map{ $0.appList }
            .bind(to: tableView.rx.items(cellIdentifier: AppListTableViewCell.identifier,
                                         cellType: AppListTableViewCell.self)) { _, element, cell in
                cell.appData = element
            }
            .disposed(by: disposeBag)
    }
}

