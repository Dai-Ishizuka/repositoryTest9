//
//  BaseNavigationController.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/08/02.
//  Copyright © 2018年 Playground, Inc.. All rights reserved.
//

import UIKit

// MARK: - Property
open class BaseNavigationController: UINavigationController {
    
}

// MARK: - Life cycle
extension BaseNavigationController {
    open override func loadView() {
        super.loadView()
        isNavigationBarHidden = true
    }
    
    open override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - Protocol
extension BaseNavigationController {
    
}

// MARK: - Method
extension BaseNavigationController {
    
}
