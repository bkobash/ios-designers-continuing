//
//  ViewController.swift
//  wk1-parallax
//
//  Created by Brian Kobashikawa on 12/12/15.
//  Copyright © 2015 Brian Kobashikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var mainScrollView: UIScrollView!
    @IBOutlet weak var pageImageView: UIImageView!
    @IBOutlet weak var photoView: UIView!
    @IBOutlet weak var photoImageView: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainScrollView.contentSize = CGSize(width: 375, height: pageImageView.frame.size.height + photoView.frame.size.height);
        mainScrollView.delegate = self;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrollY: Float = Float(scrollView.contentOffset.y);
        
        let photoWidth: CGFloat = 375;
        
        // make the photo frame larger if the user pulls down
        let photoHeight: CGFloat = max(230, 230 - CGFloat(scrollY));
        
        // make the photo image larger if the user pulls down (but not until the user scrolls 48px further)
        let photoImageHeight: CGFloat = max(320, 320 - CGFloat(scrollY) - 48);
        
        // move the photo frame up if the user pulls down
        let photoY: CGFloat = CGFloat(min(scrollY, 0));
        
        // set up the parallax Y-position
        var photoImageY: Float = -24;
        let photoImageParallaxY: Float = convertValue(scrollY, r1Min: 0, r1Max: 568, r2Min: photoImageY, r2Max: 300);
        photoImageY = max(photoImageY, photoImageParallaxY);
        
        // reposition the photo frame and image
        photoView.frame = CGRect(x: 0, y: photoY, width: photoWidth, height: photoHeight);
        photoImageView.frame = CGRect(x: 0, y: CGFloat(photoImageY), width: photoWidth, height: photoImageHeight);
    }

}

