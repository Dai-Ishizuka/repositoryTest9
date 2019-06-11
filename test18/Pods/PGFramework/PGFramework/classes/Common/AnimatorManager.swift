//
//  AnimatorManager.swift
//  Learning
//
//  Created by Playground, Inc. on 2018/11/03.
//  Copyright © 2018 Playground, Inc.. All rights reserved.
//

import UIKit

public enum NavigationType: Int {
    case push
    case pop
    case slide_push
    case slide_pop
    case none
}

open class AnimatorManager: NSObject, UIViewControllerAnimatedTransitioning {
    let animationDuration = 0.4
    open var navigationType: NavigationType = .none
    public func transitionDuration(using transitionContext:
        UIViewControllerContextTransitioning?) -> TimeInterval {
        return animationDuration
    }
    
    public func animateTransition(using transitionContext:
        UIViewControllerContextTransitioning) {

        switch navigationType {
        case .push:
            push(transitionContext)
        case .pop:
            pop(transitionContext)
        case .none:
            modal(transitionContext)
        case .slide_push:
            slide_push(transitionContext)
        case .slide_pop:
            slide_pop(transitionContext)
        }
    }
    
    public func push(_ transitionContext:
        UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        fromView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        toView.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
        containerView.addSubview(fromView)
        containerView.insertSubview(toView, aboveSubview: fromView)
        UIView.animate(withDuration: animationDuration, animations: {
            fromView.transform = CGAffineTransform.identity
            toView.transform = CGAffineTransform.identity
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    func pop(_ transitionContext:
        UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        fromView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        toView.transform = CGAffineTransform(scaleX: 3.0, y: 3.0)
        containerView.addSubview(toView)
        containerView.insertSubview(fromView, aboveSubview: toView)
        UIView.animate(withDuration: animationDuration, animations: {
            fromView.transform = CGAffineTransform.identity
            toView.transform = CGAffineTransform.identity
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
    
    func slide_push(_ transitionContext:
        UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
       
        fromView.transform =  CGAffineTransform(translationX: 0, y: 0)
        toView.transform = CGAffineTransform(translationX: fromView.frame.size.width, y: 0)
        containerView.addSubview(toView)
        containerView.insertSubview(fromView, aboveSubview: toView)
        UIView.animate(withDuration: animationDuration, animations: {
            fromView.transform = CGAffineTransform(translationX: -fromView.frame.size.width, y: 0)
            toView.transform = CGAffineTransform.identity
        }, completion: { _ in
            transitionContext.completeTransition(true)
            fromView.transform = CGAffineTransform.identity
            toView.transform = CGAffineTransform.identity
        })
    }
    func slide_pop(_ transitionContext:
        UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        fromView.transform = CGAffineTransform(translationX: 0, y: 0)
        toView.transform = CGAffineTransform(translationX: -toView.frame.size.width, y: 0)
        containerView.addSubview(toView)
        containerView.insertSubview(fromView, aboveSubview: toView)
        UIView.animate(withDuration: animationDuration, animations: {
            fromView.transform = CGAffineTransform(translationX: fromView.frame.size.width, y: 0)
            toView.transform = CGAffineTransform.identity
        }, completion: { _ in
            transitionContext.completeTransition(true)
            fromView.transform = CGAffineTransform.identity
            toView.transform = CGAffineTransform.identity
        })
    }

    func modal(_ transitionContext:
        UIViewControllerContextTransitioning) {
        let containerView = transitionContext.containerView
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        fromView.alpha = 1.0
        toView.alpha = 0.0
        containerView.addSubview(fromView)
        containerView.insertSubview(toView, aboveSubview: fromView)
        UIView.animate(withDuration: animationDuration, animations: {
            fromView.alpha = 0.0
            toView.alpha = 1.0
        }, completion: { _ in
            transitionContext.completeTransition(true)
        })
    }
}
