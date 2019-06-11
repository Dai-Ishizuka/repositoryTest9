//
//  BaseTableViewCell.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/09/20.
//  Copyright © 2018 Playground, Inc.. All rights reserved.
//

import UIKit

// MARK: - Property
open class BaseTableViewCell: UITableViewCell {

}

// MARK: - Life cycle
extension BaseTableViewCell {
    open override func awakeFromNib() {
        super.awakeFromNib()
        selectionStyle = .none
    }
}

// MARK: - Protocol
extension BaseTableViewCell {
}

// MARK: - Method
extension BaseTableViewCell {
}
