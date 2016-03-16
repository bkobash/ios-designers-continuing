//
//  CalendarYearViewMonthDataSource.swift
//  Calendar
//
//  Created by Peter Bai on 2/17/16.
//  Copyright © 2016 Peter Bai. All rights reserved.
//

import UIKit

let CalendarYearViewDayCellIdentifier = "calendarYearViewDayCell"

class CalendarYearViewMonthDataSource: NSObject, UICollectionViewDataSource, UICollectionViewDelegate {

    let calendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendarIdentifierGregorian)!
    let dateFormatter = NSDateFormatter()
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier(CalendarYearViewDayCellIdentifier, forIndexPath: indexPath) as! CalendarYearViewDayCell
        let month:Int = collectionView.tag
        
        let firstDayOfMonth: NSDate = firstDayInMonth(month)
        let firstWeekdayOfMonth: Int = weekdayForDate(firstDayOfMonth)
        let lastDayOfMonth: Int = lastDayInMonthFromStartOfMonth(firstDayOfMonth)
        
        if (indexPath.item < firstWeekdayOfMonth - 1 ||
            indexPath.item > lastDayOfMonth + firstWeekdayOfMonth - 2) {
            cell.dayLabel.text = ""
        } else {
            cell.dayLabel.text = "\(indexPath.item - firstWeekdayOfMonth + 2)"
        }
        return cell
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7 * numberOfWeeksInMonth(section + 1)
    }
    
    // MARK: - Private Methods
    
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
