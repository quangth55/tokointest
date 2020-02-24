//
//  HeadlineNewsViewController.swift
//  News
//
//  Created by QuangTH on 2/24/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class HeadlineNewsViewController: BaseViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let refreshControl = UIRefreshControl()
    
    private let viewModel = HeadlineNewsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getTopHeadlineNews()
        configureTableView()
        configureRefreshControl()
    }
    
    private func configureTableView() {
        
        tableView.refreshControl = refreshControl
        
        viewModel
            .newsList
            .bind(to: tableView.rx.items) { tableView, index, news in
                let indexPath = IndexPath(item: index, section: 0)
                if let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell {
                    cell.news = news
                    return cell
                }
                return UITableViewCell()
        }
        .disposed(by: bag)
        
        tableView
            .rx
            .modelSelected(News.self)
            .subscribe(onNext: { [weak self] news in
                
        }).disposed(by: bag)
    }
    
    private func configureRefreshControl() {
        refreshControl
            .rx
            .controlEvent(.valueChanged)
            .subscribe(onNext: { [unowned self] in
                if self.refreshControl.isRefreshing {
                    self.beginRefreshing()
                } else {
                    self.endRefreshing()
                }
            })
            .disposed(by: bag)
        tableView.refreshControl = refreshControl
    }
    
    private func endRefreshing() {
        refreshControl.endRefreshing()
    }
    
    private func beginRefreshing() {
        
        Observable<Int>
            .timer(0.75, scheduler: MainScheduler.instance)
            .take(1)
            .subscribe(onNext: { [unowned self] _ in
                self.endRefreshing()
            })
            .disposed(by: bag)
    }
}
