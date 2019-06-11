//
//  BaseView.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/09/17.
//  Copyright © 2018 Playground, Inc.. All rights reserved.
//

import UIKit


// MARK: - Property
open class BaseView: UIView {
    public var views: [Any]?
}

// MARK: - Life cycle
extension BaseView {
    open override func awakeFromNib() {
        super.awakeFromNib()
        views = loadViewFromXib(withOwner: self)
        if let contentView = views?.first as? UIView {
            contentView.frame = bounds
            contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
            addSubview(contentView)
        }
    }
}
// MARK: - Protocol
extension BaseView {
}

// MARK: - Method
extension BaseView {
}
