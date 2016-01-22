//
//  ViewController.swift
//  wk3-image-sequence
//
//  Created by Brian Kobashikawa on 1/21/16.
//  Copyright © 2016 Brian Kobashikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var introScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var pageAWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageBWidthConstraint: NSLayoutConstraint!
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(animated: Bool) {
        let scrollWidth: CGFloat = introScrollView.frame.size.width
        let scrollHeight: CGFloat = introScrollView.frame.size.height
        
        introScrollView.contentSize = CGSizeMake(scrollWidth * 2, scrollHeight)
        pageAWidthConstraint.constant = scrollWidth
        pageBWidthConstraint.constant = scrollWidth
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

