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
    
    @IBOutlet weak var bannerImageHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerImageLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerImageTrailingConstraint: NSLayoutConstraint!
    
    var eventRowData: CalendarRow!
    var eventRect: CGRect!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        
        // start with a small banner image
        bannerImageLeadingConstraint.constant = 72
        bannerImageTrailingConstraint.constant = 16
        bannerImageHeightConstraint.constant = 112
        self.view.layoutIfNeeded()
        
        // make the banner image larger
        bannerImageView.image = eventRowData.image
        self.bannerImageLeadingConstraint.constant = 0
        self.bannerImageTrailingConstraint.constant = 0
        self.bannerImageHeightConstraint.constant = 227
        UIView.animateWithDuration(0.4) { () -> Void in
            self.view.layoutIfNeeded()
        }
        
        titleLabel.alpha = 0
        UIView.animateWithDuration(0.2, delay: 0.2, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
            self.titleLabel.alpha = 1
            }, completion: nil)
        
        titleLabel.text = eventRowData.summary
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
        bannerImageLeadingConstraint.constant = 72
        bannerImageTrailingConstraint.constant = 16
        bannerImageHeightConstraint.constant = 112
        UIView.animateWithDuration(0.4) { () -> Void in
            self.view.layoutIfNeeded()
            self.closeButton.alpha = 0
            self.titleLabel.alpha = 0
        }
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
