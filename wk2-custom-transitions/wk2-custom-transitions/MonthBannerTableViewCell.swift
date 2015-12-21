//
//  MonthBannerTableViewCell.swift
//  wk2-custom-transitions
//
//  Created by Brian Kobashikawa on 12/20/15.
//  Copyright © 2015 Brian Kobashikawa. All rights reserved.
//

import UIKit

class MonthBannerTableViewCell: UITableViewCell {

    @IBOutlet weak var bannerView: UIView!
    @IBOutlet weak var bannerImageView: UIImageView!
    @IBOutlet weak var bannerImageTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var bannerLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
