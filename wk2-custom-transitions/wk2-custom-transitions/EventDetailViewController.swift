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
    }
    
    override func viewDidAppear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = .LightContent
    }
    
    override func viewWillDisappear(animated: Bool) {
        UIApplication.sharedApplication().statusBarStyle = UIStatusBarStyle.Default
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
