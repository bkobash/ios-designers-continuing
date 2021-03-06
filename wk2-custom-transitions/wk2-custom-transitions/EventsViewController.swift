//
//  EventsViewController.swift
//  wk2-custom-transitions
//
//  Created by Brian Kobashikawa on 12/20/15.
//  Copyright © 2015 Brian Kobashikawa. All rights reserved.
//

import UIKit

enum RowType {
    case BasicEvent
    case RichEvent
    case WeekSummary
    case MonthBanner
}
struct CalendarRow {
    let type: RowType
    var summary: String?
    var time: String?
    var location: String?
    var image: UIImage?
}

struct CalendarDay {
    let date: String
    let weekday: String
    let rows: [CalendarRow]
}

class EventsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate {

    @IBOutlet weak var eventTableView: UITableView!
    @IBOutlet weak var fabImageView: UIImageView!
    
    @IBOutlet weak var headerDecLabel: UILabel!
    @IBOutlet weak var headerJanLabel: UILabel!
    @IBOutlet weak var headerJanTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var fabBottomConstraint: NSLayoutConstraint!
    
    var monthBannerIndexPath: NSIndexPath!
    var monthBannerTopConstraint: NSLayoutConstraint!
    
    var selectedRowIndexPath: NSIndexPath!
    
    var calendarTransition: CalendarTransition!
    
    let events: [CalendarDay] = [
        CalendarDay(date: "17", weekday: "Thu", rows: [
            CalendarRow(type: .RichEvent, summary: "CodePath Meetup", time: "7 - 8 PM", location: "Founder's Den", image: UIImage(named: "pic-map"))
            ]),
        CalendarDay(date: "20", weekday: "Sun", rows: [
            CalendarRow(type: .BasicEvent, summary: "bring laptop to work", time: nil, location: nil, image: nil),
            CalendarRow(type: .RichEvent, summary: "Lunch with Vi", time: "12 - 1 PM", location: nil, image: UIImage(named: "pic-lunch")),
            CalendarRow(type: .RichEvent, summary: "Coffee with Joe", time: "2 - 2:30 PM", location: nil, image: UIImage(named: "pic-coffee"))
            ]),
        CalendarDay(date: "24", weekday: "Thu", rows: [
            CalendarRow(type: .RichEvent, summary: "Christmas Eve", time: nil, location: nil, image: UIImage(named: "pic-xmas")),
             CalendarRow(type: .BasicEvent, summary: "Cook turkey", time: nil, location: nil, image: nil),
             CalendarRow(type: .BasicEvent, summary: "Unwrap presents", time: nil, location: nil, image: nil)
            ]),
        CalendarDay(date: "25", weekday: "Fri", rows: [
            CalendarRow(type: .RichEvent, summary: "Christmas Day", time: nil, location: nil, image: UIImage(named: "pic-xmas")),
            ]),
        CalendarDay(date: "", weekday: "", rows: [
            CalendarRow(type: .WeekSummary, summary: "Week 53, December 27 - January 2", time: nil, location: nil, image: nil)
            ]),
        CalendarDay(date: "28", weekday: "Mon", rows: [
            CalendarRow(type: .RichEvent, summary: "Ramen time", time: "8 - 9 PM", location: "Ramen Yamadaya", image: UIImage(named: "pic-ramen"))
            ]),
        CalendarDay(date: "30", weekday: "Fri", rows: [
            CalendarRow(type: .RichEvent, summary: "Yoga Tree - Yin", time: "8 - 9:30 PM", location: nil, image: UIImage(named: "pic-yoga"))
            ]),
        CalendarDay(date: "", weekday: "", rows: [
            CalendarRow(type: .MonthBanner, summary: "Jan 2016", time: nil, location: nil, image: UIImage(named: "pic-lunch"))
            ]),
        CalendarDay(date: "1", weekday: "Fri", rows: [
            CalendarRow(type: .RichEvent, summary: "New Year's Day", time: "1 - 2 AM", location: nil, image: UIImage(named: "pic-newyears"))
            ]),
        CalendarDay(date: "", weekday: "", rows: [
            CalendarRow(type: .WeekSummary, summary: "Week 1, January 3 - January 9", time: nil, location: nil, image: nil)
            ]),
        CalendarDay(date: "3", weekday: "Sun", rows: [
            CalendarRow(type: .BasicEvent, summary: "Birthday - Teddy Jacobson", time: nil, location: nil, image: nil),
            CalendarRow(type: .RichEvent, summary: "Take Kingsley to Flea Market", time: "2 - 4 PM", location: "Treasure Island Flea Market", image: UIImage(named: "pic-map"))
            ]),
        CalendarDay(date: "4", weekday: "Mon", rows: [
            CalendarRow(type: .RichEvent, summary: "Star Wars", time: "7 - 10 PM", location: "AMC Metreon 16", image: UIImage(named: "pic-metreon"))
            ]),
        CalendarDay(date: "5", weekday: "Tue", rows: [
            CalendarRow(type: .RichEvent, summary: "Coffee with Joe", time: "10 - 11 AM", location: nil, image: UIImage(named: "pic-coffee")),
            CalendarRow(type: .RichEvent, summary: "Museum trip", time: "7 - 10 PM", location: "de Young Museum", image: UIImage(named: "pic-deyoung"))
            ]),
        
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        eventTableView.delegate = self
        eventTableView.dataSource = self
        eventTableView.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if (segue.identifier == "showDetail") {
            
            let eventDetailVC = segue.destinationViewController as! EventDetailViewController
            let eventRowData = events[selectedRowIndexPath.section].rows[selectedRowIndexPath.row]
            let eventRowRect = eventTableView.rectForRowAtIndexPath(selectedRowIndexPath);
            let eventRect = CGRect(x: 72, y: eventRowRect.origin.y - eventTableView.contentOffset.y + 76, width: eventRowRect.size.width - 88, height: eventRowRect.size.height - 8)

            calendarTransition = CalendarTransition()
            calendarTransition.eventRect = eventRect
            calendarTransition.duration = 0.4
            
            eventDetailVC.eventRowData = eventRowData
            eventDetailVC.eventRect = eventRect
            eventDetailVC.duration = 0.4
            eventDetailVC.modalPresentationStyle = UIModalPresentationStyle.Custom
            eventDetailVC.transitioningDelegate = calendarTransition
            
            fabBottomConstraint.constant = -72
            UIView.animateWithDuration(0.2, animations: { () -> Void in
                self.view.layoutIfNeeded()
                })
            delay(0.4, closure: { () -> () in
                self.fabBottomConstraint.constant = 0
                self.view.layoutIfNeeded()
            })
        }
    }
    
    // MARK: - Tables
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return events.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events[section].rows.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {

        let rowData: CalendarRow = events[indexPath.section].rows[indexPath.row];
        
        switch (rowData.type) {
            case RowType.BasicEvent:
                
                let cell: BasicEventTableViewCell = tableView.dequeueReusableCellWithIdentifier("BasicEventCell") as! BasicEventTableViewCell
                cell.titleLabel.text = rowData.summary
                cell.eventBubbleView.layer.cornerRadius = 2
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            
            case RowType.RichEvent:
                
                let cell: RichEventTableViewCell = tableView.dequeueReusableCellWithIdentifier("RichEventCell") as! RichEventTableViewCell
                cell.titleLabel.text = rowData.summary
                cell.locationLabel.text = rowData.location
                cell.timeLabel.text = rowData.time
                if (rowData.location == nil && rowData.time == nil) {
                    cell.titleBottomConstraint.constant = 9
                } else if (rowData.location == nil) {
                    cell.titleBottomConstraint.constant = 26
                    cell.timeBottomConstraint.constant = 9
                } else if (rowData.time == nil) {
                    cell.titleBottomConstraint.constant = 26
                } else {
                    cell.titleBottomConstraint.constant = 44
                    cell.timeBottomConstraint.constant = 26
                }
                cell.pictureImageView.image = rowData.image
                cell.eventBubbleView.layer.cornerRadius = 2
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            
            case RowType.WeekSummary:
                
                let cell: WeekSummaryTableViewCell = tableView.dequeueReusableCellWithIdentifier("WeekSummaryCell") as! WeekSummaryTableViewCell
                cell.summaryLabel.text = rowData.summary
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            
            case RowType.MonthBanner:
                
                let cell: MonthBannerTableViewCell = tableView.dequeueReusableCellWithIdentifier("MonthBannerCell") as! MonthBannerTableViewCell
                monthBannerIndexPath = indexPath
                monthBannerTopConstraint = cell.bannerImageTopConstraint
                cell.bannerLabel.text = rowData.summary
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                return cell
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let rowData: CalendarRow = events[indexPath.section].rows[indexPath.row];
        
        switch (rowData.type) {

            case RowType.BasicEvent:
                return 40
            
            case RowType.RichEvent:
                return 112
            
            case RowType.WeekSummary:
                return 18
            
            case RowType.MonthBanner:
                return 148
        
        }
        
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 0.001
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 24
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView: HeaderTableViewCell = tableView.dequeueReusableCellWithIdentifier("HeaderCell") as! HeaderTableViewCell
        
        headerView.backgroundColor = UIColor.clearColor()
        headerView.dateLabel.text = events[section].date
        headerView.weekdayLabel.text = events[section].weekday
        headerView.tag = 10000 + section
        
        return headerView
        
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let footerView: UIView = UIView()
        footerView.backgroundColor = UIColor.clearColor()
        return footerView
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let rowData: CalendarRow = events[indexPath.section].rows[indexPath.row];
        if (rowData.type == RowType.BasicEvent || rowData.type == RowType.RichEvent) {
            selectedRowIndexPath = indexPath
            dispatch_async(dispatch_get_main_queue(),{
                self.performSegueWithIdentifier("showDetail", sender: self)
            })
        }
    }
    
    // MARK: - Scrolling
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        
        let scrollY: Float = Float(scrollView.contentOffset.y);
       
        if (monthBannerIndexPath != nil) {
            let monthBannerRect: CGRect = eventTableView.rectForRowAtIndexPath(monthBannerIndexPath)
            let monthBannerY: Float = Float(monthBannerRect.origin.y)
            
             // create parallax effect for the month banner
            let scrollDistance: Float = Float(eventTableView.frame.size.height) - 148 // overall scrollview height (591) minus image container height (148)
            let parallaxY: Float = convertValue(scrollY, r1Min: monthBannerY - scrollDistance, r1Max: monthBannerY, r2Min: -100, r2Max: 0);
            monthBannerTopConstraint.constant = CGFloat(parallaxY)
            
            // update the header when the month banner
            // moves up to the top
            headerDecLabel.alpha = 1 - CGFloat(scrollY - monthBannerY) * 0.02
            headerJanLabel.alpha = CGFloat(scrollY - monthBannerY) * 0.02
            headerJanTopConstraint.constant = max(CGFloat(monthBannerY - scrollY) + 91, 37)

        }
        
        // fix the section header positioning as cells scroll off
        if (eventTableView.visibleCells.count > 0) {
            
            // only check the topmost section
            let cell: UITableViewCell = eventTableView.visibleCells[0]
            let section: Int = eventTableView.indexPathForCell(cell)!.section
            let lastCellRow: Int = eventTableView.numberOfRowsInSection(section) - 1
            let lastCell: UITableViewCell = eventTableView.cellForRowAtIndexPath(NSIndexPath(forRow: lastCellRow, inSection: section))!
            let scrollDelta: CGFloat = lastCell.frame.origin.y - CGFloat(scrollY)
            
            // using tags to find and update the custom section view
            // http://stackoverflow.com/questions/3746984/
            let sectionView: HeaderTableViewCell = self.view.viewWithTag(10000 + section) as! HeaderTableViewCell
            
            // update the top constraint for the date (in the section header)
            // so that it slides out as the last table cell is 45pt off the screen
            if (lastCell.isKindOfClass(RichEventTableViewCell)) {
                sectionView.dateTopConstraint.constant = min(scrollDelta + 45, 0)
            } else {
                sectionView.dateTopConstraint.constant = min(scrollDelta - 25, 0)
            }
                
        }
    }

}
