//
//  CalendarMonthViewDayCell.swift
//  Calendar
//
//  Created by Peter Bai on 2/27/16.
//  Copyright © 2016 Peter Bai. All rights reserved.
//

import UIKit

class CalendarMonthViewDayCell: UICollectionViewCell {
    
    @IBOutlet weak var dotView: UIView!
    @IBOutlet weak var dayLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func hideDate() {
        dayLabel.hidden = true
        dotView.hidden = true
    }
    
    func showDate() {
        dayLabel.hidden = false
        dotView.hidden = false
    }

}
