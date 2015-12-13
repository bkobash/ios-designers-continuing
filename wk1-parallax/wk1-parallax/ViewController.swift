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
    @IBOutlet weak var photoBlurredImageView: UIImageView!
    @IBOutlet weak var photo1View: UIView!
    @IBOutlet weak var photo1ImageView: UIImageView!
    @IBOutlet weak var photo2View: UIView!
    @IBOutlet weak var photo2ImageView: UIImageView!
    @IBOutlet weak var photo3View: UIView!
    @IBOutlet weak var photo3ImageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        mainScrollView.contentSize = CGSize(width: 375, height: pageImageView.frame.size.height + photoView.frame.size.height);
        mainScrollView.delegate = self;
    }
    
    override func viewWillAppear(animated: Bool) {
        photoBlurredImageView.alpha = 0;
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
        let photoImageParallaxY: Float = convertValue(scrollY, r1Min: 0, r1Max: 667, r2Min: photoImageY, r2Max: 300);
        photoImageY = max(photoImageY, photoImageParallaxY);
        
        // "blur" the image as the user scrolls up
        let photoBlurredAlpha: Float = convertValue(scrollY, r1Min: 0, r1Max: 160, r2Min: 0, r2Max: 1);
        
        // reposition the photo frame and image
        photoView.frame = CGRect(x: 0, y: photoY, width: photoWidth, height: photoHeight);
        photoImageView.frame = CGRect(x: 0, y: CGFloat(photoImageY), width: photoWidth, height: photoImageHeight);
        photoBlurredImageView.frame = CGRect(x: 0, y: CGFloat(photoImageY), width: photoWidth, height: photoImageHeight);
        photoBlurredImageView.alpha = CGFloat(photoBlurredAlpha);
        
        // parallax a few more images
        // scrollDistance is the scrollView's height (604) minus the image container height (216)
        let scrollDistance: CGFloat = 387;
        let photo1ImageParallaxY: Float = convertValue(scrollY, r1Min: Float(photo1View.frame.origin.y - scrollDistance), r1Max: Float(photo1View.frame.origin.y), r2Min: -100, r2Max: 0);
        let photo2ImageParallaxY: Float = convertValue(scrollY, r1Min: Float(photo2View.frame.origin.y - scrollDistance), r1Max: Float(photo2View.frame.origin.y), r2Min: -100, r2Max: 0);
        let photo3ImageParallaxY: Float = convertValue(scrollY, r1Min: Float(photo3View.frame.origin.y - scrollDistance), r1Max: Float(photo3View.frame.origin.y), r2Min: -100, r2Max: 0);
        photo1ImageView.frame = CGRect(x: 0, y: CGFloat(photo1ImageParallaxY), width: 343, height: 316);
        photo2ImageView.frame = CGRect(x: 0, y: CGFloat(photo2ImageParallaxY), width: 343, height: 316);
        photo3ImageView.frame = CGRect(x: 0, y: CGFloat(photo3ImageParallaxY), width: 343, height: 316);
        
        
    }

}

