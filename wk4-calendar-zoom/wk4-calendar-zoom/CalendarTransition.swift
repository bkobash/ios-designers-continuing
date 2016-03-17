//
//  CalendarTransition.swift
//
//  Created by Brian Kobashikawa on 12/23/15.
//  Copyright (c) 2015 Brian Kobashikawa. All rights reserved.
//

import UIKit

class CalendarTransition: BaseTransition {
    
    var eventRect: CGRect!
    var isPopped: Bool! = false
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        containerView.backgroundColor = UIColor.whiteColor()
        
        let scaleFactor: CGFloat = 0.29 // hack to get the months properly aligned
        let yOffset: CGFloat = 110 - (eventRect.origin.y / 20); // hack to get the months properly aligned
        
        let superXOffset: CGFloat = eventRect.origin.x * 2.8;
        let superYOffset: CGFloat = (eventRect.origin.y + 80 - (eventRect.origin.y / 5)) * 3.8; // yuck.
        
        // minimized month view
        let minAlpha: CGFloat = 0.0
        let minTransform: CGAffineTransform = CGAffineTransformMakeScale(scaleFactor, scaleFactor)
        let minOrigin: CGPoint = CGPointMake(eventRect.origin.x, eventRect.origin.y + yOffset)
        
        // full screen
        let maxAlpha: CGFloat = 1.0
        let maxTransform: CGAffineTransform = CGAffineTransformMakeScale(1, 1)
        let maxOrigin: CGPoint = UIScreen.mainScreen().bounds.origin
        
        // year view expands to 3x the normal size
        let superAlpha: CGFloat = 1.0
        let superTransform: CGAffineTransform = CGAffineTransformMakeScale(3, 3)
        let superOrigin: CGPoint = CGPointMake(0 - superXOffset, 0 - superYOffset)
        
        // set destination values
        var fromVCAlpha: CGFloat = superAlpha
        var fromVCTransform: CGAffineTransform = superTransform
        var fromVCOrigin: CGPoint = superOrigin
        var toVCAlpha: CGFloat = maxAlpha
        var toVCTransform: CGAffineTransform = maxTransform
        var toVCOrigin: CGPoint = maxOrigin
        
        // set initial values, if needed
        if (isPopped == false) {
            
            toViewController.view.transform = minTransform
            toViewController.view.frame.origin = minOrigin
            toViewController.view.alpha = minAlpha
            
        } else {
            
            fromVCAlpha = minAlpha
            fromVCTransform = minTransform
            fromVCOrigin = minOrigin
            toVCAlpha = maxAlpha
            toVCTransform = maxTransform
            toVCOrigin = maxOrigin
            
            toViewController.view.frame.origin = superOrigin
            
            containerView.insertSubview(fromViewController.view, aboveSubview: toViewController.view)
            
        }
        
        UIView.animateWithDuration(duration, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            fromViewController.view.alpha = fromVCAlpha
            fromViewController.view.transform = fromVCTransform
            fromViewController.view.frame.origin = fromVCOrigin
            
            toViewController.view.alpha = toVCAlpha
            toViewController.view.transform = toVCTransform
            toViewController.view.frame.origin = toVCOrigin
            
        }) { (finished: Bool) -> Void in
            self.finish()
        }
        
        
    }
    
}
