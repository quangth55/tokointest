//
//  HomeViewController.swift
//  News
//
//  Created by QuangTH on 2/23/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import UIKit
import PagingKit

class HomeViewController: BaseViewController {
    
    var menuViewController: PagingMenuViewController!
    
    var contentViewController: PagingContentViewController!
    
    var dataSource : [(menuTitle: String, content: UIViewController)] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        configurePage()
        configureDataSource()
        menuViewController.reloadData()
        contentViewController.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    private func configurePage() {
        menuViewController.register(nib: UINib(nibName: "PagingTabView", bundle: Bundle.main), forCellWithReuseIdentifier: PagingTabView.reuseIdentifier)
        menuViewController.registerFocusView(nib: UINib(nibName: "SelectedTabView", bundle: Bundle.main))
    }
    
    private func configureDataSource() {
        dataSource.append((menuTitle: TabType.headline.rawValue, content: UIViewController()))
        dataSource.append((menuTitle: TabType.headline.rawValue, content: UIViewController()))
        dataSource.append((menuTitle: TabType.headline.rawValue, content: UIViewController()))
    }
}

enum TabType: String {
    case headline = "Headline"
    case custom = "Custom"
    case profile = "Profile"
}

extension HomeViewController: PagingMenuViewControllerDataSource {
    func numberOfItemsForMenuViewController(viewController: PagingMenuViewController) -> Int {
        return dataSource.count
    }
    
    func menuViewController(viewController: PagingMenuViewController, widthForItemAt index: Int) -> CGFloat {
        return Constants.Screen.width / CGFloat(dataSource.count)
    }
    
    func menuViewController(viewController: PagingMenuViewController, cellForItemAt index: Int) -> PagingMenuViewCell {
        guard let cell = viewController.dequeueReusableCell(withReuseIdentifier: PagingTabView.reuseIdentifier, for: index) as? PagingTabView else {
            return PagingTabView()
        }
        cell.tabLabel.text = dataSource[index].menuTitle
        return cell
    }
}

extension HomeViewController: PagingContentViewControllerDataSource {
    func numberOfItemsForContentViewController(viewController: PagingContentViewController) -> Int {
        return dataSource.count
    }
    
    func contentViewController(viewController: PagingContentViewController, viewControllerAt index: Int) -> UIViewController {
        return dataSource[index].content
    }
}

extension HomeViewController: PagingMenuViewControllerDelegate {
    
    func menuViewController(viewController: PagingMenuViewController, didSelect page: Int, previousPage: Int) {
        contentViewController.scroll(to: page, animated: true)
    }
}

extension HomeViewController: PagingContentViewControllerDelegate {
    
    func contentViewController(viewController: PagingContentViewController, didManualScrollOn index: Int, percent: CGFloat) {
        menuViewController.scroll(index: index, percent: percent, animated: false)
    }
}
