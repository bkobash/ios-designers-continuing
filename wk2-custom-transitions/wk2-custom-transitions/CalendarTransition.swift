//
//  FadeTransition.swift
//  transitionDemo
//
//  Created by Timothy Lee on 11/4/14.
//  Copyright (c) 2014 Timothy Lee. All rights reserved.
//

import UIKit

class CalendarTransition: BaseTransition {
    
    var eventRect: CGRect!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        toViewController.view.clipsToBounds = true
        toViewController.view.frame = CGRect(x: 0, y: eventRect.origin.y, width: UIScreen.mainScreen().bounds.size.width, height: eventRect.size.height)
        UIView.animateWithDuration(duration, animations: {
            toViewController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height)
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        //fromViewController.view.frame = CGRect(x: 0, y: 0, width: UIScreen.mainScreen().bounds.size.width, height: UIScreen.mainScreen().bounds.size.height)
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.frame = CGRect(x: 0, y: self.eventRect.origin.y, width: UIScreen.mainScreen().bounds.size.width, height: self.eventRect.size.height)
        }) { (finished: Bool) -> Void in
            self.finish()
        }
        // Adding a little fade to polish it a bit
        UIView.animateWithDuration(0.1, delay: 0.3, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            fromViewController.view.alpha = 0
            }, completion: nil)
    }
}
