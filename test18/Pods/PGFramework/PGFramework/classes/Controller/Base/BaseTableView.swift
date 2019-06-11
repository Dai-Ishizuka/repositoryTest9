//
//  BaseTableView.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/09/17.
//  Copyright © 2018 Playground, Inc.. All rights reserved.
//

import UIKit


// MARK: - Property
open class BaseTableView: UITableView {

}

// MARK: - Life cycle
extension BaseTableView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        separatorStyle = .none
    }
}

// MARK: - Protocol
extension BaseTableView {
}

// MARK: - Method
extension BaseTableView {
}
