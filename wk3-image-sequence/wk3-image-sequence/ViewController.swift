//
//  ViewController.swift
//  wk3-image-sequence
//
//  Created by Brian Kobashikawa on 1/21/16.
//  Copyright © 2016 Brian Kobashikawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var introScrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!

    @IBOutlet weak var pageAImageView: UIImageView!
    @IBOutlet weak var pageBImageView: UIImageView!
    
    @IBOutlet weak var pageAWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var pageBWidthConstraint: NSLayoutConstraint!
    
    var pageAArray:[UIImage] = []
    var pageBArray:[UIImage] = []
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var img: UIImage?
        for imgFrame in 0...209 {
            img = UIImage(named: "AppointmentsAnimation_01_\(imgFrame).png")
            if img != nil {
                pageAArray.append(img!)
            }
        }
        for imgFrame in 0...269 {
            img = UIImage(named: "AppointmentsAnimation_02_\(imgFrame).png")
            if img != nil {
                pageBArray.append(img!)
            }
        }
        pageAImageView.animationImages = pageAArray
        pageBImageView.animationImages = pageBArray
        
        pageAImageView.animationRepeatCount = 1
        pageBImageView.animationRepeatCount = 1
        
        pageAImageView.animationDuration = 7
        pageBImageView.animationDuration = 9
        
        introScrollView.delegate = self
    }
    
    override func viewDidAppear(animated: Bool) {
        
        // Ideally, setting up the scrollview  contentSize
        // would have happened in viewDidLoad. But it doesn't
        // work. Need to look into this more...
        let scrollWidth: CGFloat = introScrollView.frame.size.width
        let scrollHeight: CGFloat = introScrollView.frame.size.height
        
        introScrollView.contentSize = CGSizeMake(scrollWidth * 2, scrollHeight)
        pageAWidthConstraint.constant = scrollWidth
        pageBWidthConstraint.constant = scrollWidth

        startPageAnimation(pageAImageView)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func startPageAnimation(imageView: UIImageView) {
        imageView.image = imageView.animationImages?.last
        imageView.startAnimating()
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        
        pageAImageView.stopAnimating()
        pageBImageView.stopAnimating()
    }

    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        let scrollX = scrollView.contentOffset.x
        let scrollWidth = scrollView.frame.size.width
        if (scrollX >= scrollWidth) {
            startPageAnimation(pageBImageView)
            pageAImageView.image = pageAImageView.animationImages?.first
        } else {
            startPageAnimation(pageAImageView)
            pageBImageView.image = pageBImageView.animationImages?.first
        }
    }

}

