//
//  CalendarYearViewController.swift
//  Calendar
//
//  Created by Peter Bai on 2/14/16.
//  Copyright © 2016 Peter Bai. All rights reserved.
//

import UIKit

let CalendarYearViewMonthCellIdentifier = "calendarYearViewMonthCell"
var selectedIndexPath: NSIndexPath!

class CalendarYearViewController: UIViewController {
    
    
    @IBOutlet weak var yearCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    private let monthData: [Int] = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12]
    private var monthDataSource: CalendarYearViewMonthDataSource = CalendarYearViewMonthDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        yearCollectionView.dataSource = self
        yearCollectionView.delegate = self
        yearCollectionView.registerNib(UINib(nibName: "CalendarYearViewMonthCell", bundle: nil), forCellWithReuseIdentifier: CalendarYearViewMonthCellIdentifier)
        
        let windowWidth: CGFloat = view.frame.size.width
        let itemSpacing: CGFloat = 8.0
        let insetDistance: CGFloat = 20.0
        let itemWidth: CGFloat = (windowWidth - 2 * insetDistance) / 3.0 - itemSpacing
        flowLayout.sectionInset = UIEdgeInsets(top: insetDistance, left: insetDistance, bottom: insetDistance, right: insetDistance)
        flowLayout.itemSize = CGSizeMake(itemWidth, 128.0)
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.minimumLineSpacing = 0
        
        title = "2016"
        navigationController?.navigationBar.tintColor = UIColor.redColor()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        
        let monthVC = segue.destinationViewController as! CalendarMonthViewController
        print (selectedIndexPath.item)
        monthVC.selectedMonthIndex = selectedIndexPath.item
    }
}

extension CalendarYearViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = yearCollectionView.dequeueReusableCellWithReuseIdentifier(CalendarYearViewMonthCellIdentifier, forIndexPath: indexPath) as! CalendarYearViewMonthCell
        let month: Int = monthData[indexPath.row]
        cell.monthLabel.text = monthNames[month]
        cell.monthCollectionView.registerNib(UINib(nibName: "CalendarYearViewDayCell", bundle: nil), forCellWithReuseIdentifier: CalendarYearViewDayCellIdentifier)
        cell.setCollectionViewDataSourceDelegate(monthDataSource, forMonth: month)
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return monthData.count
    }
}

extension CalendarYearViewController: UICollectionViewDelegate {
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        //let calendarMonthViewController = CalendarMonthViewController()
        //calendarMonthViewController.selectedMonthIndex = indexPath.item
        //self.navigationController?.pushViewController(calendarMonthViewController, animated: true)
        selectedIndexPath = indexPath
        self.performSegueWithIdentifier("showMonthView", sender: self)
    }
}