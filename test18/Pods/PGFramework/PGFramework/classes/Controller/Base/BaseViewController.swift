//
//  BaseViewController.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/09/17.
//  Copyright © 2018 Playground, Inc.. All rights reserved.
//

import UIKit


// MARK: - Property
open class BaseViewController: UIViewController {
    // manager
    public var animatorManager = AnimatorManager()
}

// MARK: - Life cycle
extension BaseViewController {
    override open func loadView() {
        super.loadView()
        let _ = loadViewFromXib(withOwner: self)
    }
   
    override open func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController {
            navigationController.delegate = self
        }

        if let tabBarController = tabBarController {
            tabBarController.delegate = self
        }
    }
    
    override open func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override open func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - Protocol
extension BaseViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController,
                              animationControllerFor operation: UINavigationController.Operation,
                              from fromVC: UIViewController,
                              to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return animatorManager
    }
}

extension BaseViewController: UITabBarControllerDelegate {
    public func tabBarController(_ tabBarController: UITabBarController,
                          animationControllerForTransitionFrom fromVC: UIViewController,
                          to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        animatorManager.navigationType = .none
        return animatorManager
    }
}

// MARK: - method
extension BaseViewController {
    
}

