//
//  PagingTabView.swift
//  News
//
//  Created by QuangTH on 2/23/20.
//  Copyright © 2020 quangth. All rights reserved.
//

import UIKit
import PagingKit

class PagingTabView: PagingMenuViewCell {
    
    @IBOutlet weak var tabLabel: UILabel!
    
    static let reuseIdentifier = "PagingTabView"
    
    override public var isSelected: Bool {
        didSet {
            if isSelected {
                tabLabel.font = .boldSystemFont(ofSize: 12)
                tabLabel.textColor = .black
            } else {
                tabLabel.font = .systemFont(ofSize: 12)
                tabLabel.textColor = .darkGray
            }
        }
    }
    
    var title: String {
        get {
            return tabLabel.text ?? ""
        }
        set {
            tabLabel.text = newValue
        }
    }
    
    var titleLabel: UILabel {
        return tabLabel
    }
}
