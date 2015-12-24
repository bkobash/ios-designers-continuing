//
//  EventDetailViewController.swift
//  wk2-custom-transitions
//
//  Created by Brian Kobashikawa on 12/20/15.
//  Copyright © 2015 Brian Kobashikawa. All rights reserved.
//

import UIKit

class EventDetailViewController: UIViewController {

    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var editImageView: UIImageView!
    
    @IBOutlet weak var bannerImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLeadingConstraint: NSLayoutConstraint!
    
    var eventRowData: CalendarRow!
    var eventRect: CGRect!
    var duration: Double!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        bannerImageView.image = eventRowData.image
        titleLabel.text = eventRowData.summary
        
        bannerImageHeightConstraint.constant = eventRect.size.height + 36
        titleLeadingConstraint.constant = 16
        editImageView.transform = CGAffineTransformMakeScale(0, 0)
        self.closeButton.alpha = 0
            
        self.view.layoutIfNeeded()
        
        bannerImageHeightConstraint.constant = 227
        titleLeadingConstraint.constant = 72
        UIView.animateWithDuration(duration) { () -> Void in
            self.view.layoutIfNeeded()
        }
        UIView.animateWithDuration(0.2, delay: duration, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            self.editImageView.transform = CGAffineTransformMakeScale(1, 1)
            self.closeButton.alpha = 1
            }, completion: nil)
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        
        bannerImageHeightConstraint.constant = eventRect.size.height + 36
        titleLeadingConstraint.constant = 16
        self.editImageView.transform = CGAffineTransformMakeScale(1, 1);
        UIView.animateWithDuration(duration) { () -> Void in
            self.editImageView.alpha = 0
            self.closeButton.alpha = 0
            self.view.layoutIfNeeded()
            
        }
        
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func onCloseTap(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
}
