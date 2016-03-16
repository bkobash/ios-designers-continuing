//
//  CalendarMonthViewController.swift
//  wk4-calendar-zoom
//
//  Created by Brian Kobashikawa on 3/12/16.
//  Copyright © 2016 Brian Kobashikawa. All rights reserved.
//

import UIKit

let CalendarMonthViewDayCellIdentifier = "calendarMonthViewDayCellIdentifier"
let CalendarMonthViewHeaderYearViewIdentifier = "calendarMonthViewHeaderYearViewIdentifier"

class CalendarMonthViewController: UIViewController {
    
    var selectedMonthIndex: Int = 0
    
    private let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    private let dateFormatter = NSDateFormatter()

    
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var flowLayout: UICollectionViewFlowLayout!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.registerNib(UINib(nibName: "CalendarMonthViewDayCell", bundle: nil), forCellWithReuseIdentifier: CalendarMonthViewDayCellIdentifier)
        collectionView.registerNib(UINib(nibName: "CalendarMonthViewHeaderYearView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: CalendarMonthViewHeaderYearViewIdentifier)
        collectionView.reloadData()
        
        let windowWidth: CGFloat = view.frame.size.width
        let itemsPerRow: CGFloat = 7.0
        let itemSpacing: CGFloat = 0.0
        let insetDistance: CGFloat = 10.0
        let itemWidth: CGFloat = (windowWidth - 2 * insetDistance) / itemsPerRow - itemSpacing
        let itemHeight: CGFloat = 60.0
        flowLayout.sectionInset = UIEdgeInsets(top: insetDistance, left: insetDistance, bottom: insetDistance, right: insetDistance)
        flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight)
        flowLayout.minimumInteritemSpacing = itemSpacing
        flowLayout.minimumLineSpacing = 0
    }
    
    override func viewWillLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        collectionView.collectionViewLayout.prepareLayout()
        var offsetY: CGFloat = (collectionView.layoutAttributesForSupplementaryElementOfKind(UICollectionElementKindSectionHeader, atIndexPath: NSIndexPath(forItem: 0, inSection: selectedMonthIndex))?.frame.origin.y)!
        offsetY -= 64.0 // navigation bar height
        collectionView.setContentOffset(CGPoint(x: collectionView.contentOffset.x, y: offsetY), animated: false)
    }
}

extension CalendarMonthViewController: UICollectionViewDataSource {
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CalendarMonthViewDayCellIdentifier, forIndexPath: indexPath) as! CalendarMonthViewDayCell
        
        let month: Int = indexPath.section + 1
        let firstDayOfMonth: NSDate = firstDayInMonth(month)
        let firstWeekdayOfMonth: Int = weekdayForDate(firstDayOfMonth)
        let lastDayOfMonth: Int = lastDayInMonthFromStartOfMonth(firstDayOfMonth)
        
        if (indexPath.item < firstWeekdayOfMonth - 1 ||
            indexPath.item > lastDayOfMonth + firstWeekdayOfMonth - 2) {
                cell.hideDate()
        } else {
            cell.showDate()
            cell.dayLabel.text = "\(indexPath.item - firstWeekdayOfMonth + 2)"
        }
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 12
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 * numberOfWeeksInMonth(section + 1)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionElementKindSectionHeader:
            let month: Int = indexPath.section + 1
            guard month >= 1 && month <= 12 else {
                assert(false, "Unexpected month")
            }
            let headerView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                withReuseIdentifier: CalendarMonthViewHeaderYearViewIdentifier,
                forIndexPath: indexPath) as! CalendarMonthViewHeaderYearView
            headerView.monthLabel.text = monthNames[month]
            return headerView
        default:
            assert(false, "Unexpected element kind")
        }
    }
}

extension CalendarMonthViewController: UICollectionViewDelegate {
    
}

// MARK - Private methods
extension CalendarMonthViewController {
    
    private func firstDayInMonth(month: Int) -> NSDate {
        // Use start with current year and month
        let components = calendar.components([.Year, .Month], fromDate: NSDate())
        
        // Manually set month
        components.month = month
        return calendar.dateFromComponents(components)!
    }
    
    private func lastDayInMonthFromStartOfMonth(startOfMonth: NSDate) -> Int {
        let components = NSDateComponents()
        components.month = 1
        components.day = -1
        let endOfMonth = calendar.dateByAddingComponents(components, toDate: startOfMonth, options: [])
        return calendar.component(NSCalendarUnit.Day, fromDate: endOfMonth!)
    }
    
    private func weekdayForDate(date: NSDate) -> Int {
        let components = calendar.components(.Weekday, fromDate: date)
        return components.weekday
    }
    
    private func numberOfWeeksInMonth(month: Int) -> Int {
        let components = calendar.components([.Year, .Month], fromDate: NSDate())
        components.month = month
        let weekRange = calendar.rangeOfUnit(.WeekOfMonth, inUnit: .Month, forDate: calendar.dateFromComponents(components)!)
        return weekRange.length
    }
}