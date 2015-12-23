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
        
        toViewController.view.clipsToBounds = true
        toViewController.view.frame = CGRect(x: 0, y: eventRect.origin.y, width: UIScreen.mainScreen().bounds.size.width, height: eventRect.size.height)
        UIView.animateWithDuration(duration, animations: {
            toViewController.view.frame = UIScreen.mainScreen().bounds
        }) { (finished: Bool) -> Void in
            self.finish()
        }
    }
    
    override func dismissTransition(containerView: UIView, fromViewController: UIViewController, toViewController: UIViewController) {
        
        fromViewController.view.alpha = 1
        UIView.animateWithDuration(duration, animations: {
            fromViewController.view.frame = CGRect(x: 0, y: self.eventRect.origin.y, width: UIScreen.mainScreen().bounds.size.width, height: self.eventRect.size.height)
        }) { (finished: Bool) -> Void in
            self.finish()
        }
        // Adding a little fade to polish it a bit
        UIView.animateWithDuration(0.1, delay: duration - 0.1, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            fromViewController.view.alpha = 0
            }, completion: nil)
    }
}
