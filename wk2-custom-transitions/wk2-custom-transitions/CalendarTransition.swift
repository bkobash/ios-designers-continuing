//
//  CalendarTransition.swift
//
//  Created by Brian Kobashikawa on 12/23/15.
//  Copyright (c) 2015 Brian Kobashikawa. All rights reserved.
//

import UIKit

class CalendarTransition: BaseTransition {
    
    var eventRect: CGRect!
    
    override func presentTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
        let screenHeight: CGFloat = UIScreen.mainScreen().bounds.size.height
        let scaleFactor = eventRect.size.width / screenWidth
        
        toViewController.view.clipsToBounds = true
        toViewController.view.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor)
        toViewController.view.frame.origin = eventRect.origin
        toViewController.view.frame.size.height = eventRect.size.height
        
        UIView.animateWithDuration(duration, animations: {
            toViewController.view.transform = CGAffineTransformMakeScale(1, 1)
            toViewController.view.frame.origin = UIScreen.mainScreen().bounds.origin
            toViewController.view.frame.size.height = screenHeight
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        let screenWidth: CGFloat = UIScreen.mainScreen().bounds.size.width
        let scaleFactor = eventRect.size.width / screenWidth
        
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.transform = CGAffineTransformMakeScale(scaleFactor, scaleFactor)
            fromViewController.view.frame.origin = self.eventRect.origin
            fromViewController.view.frame.size.height = self.eventRect.size.height
        }) { (finished: Bool) -> Void in
            self.finish()
        }
        
        // Adding a little fade to polish it a bit
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(0.1, delay: duration - 0.1, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            fromViewController.view.alpha = 0
            }, completion: nil)
    }
}
