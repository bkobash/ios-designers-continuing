//
//  CalendarYearViewMonthCell.swift
//  Calendar
//
//  Created by Peter Bai on 2/14/16.
//  Copyright © 2016 Peter Bai. All rights reserved.
//

import UIKit

class CalendarYearViewMonthCell: UICollectionViewCell {
    
    var month:NSInteger = 0

    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var monthCollectionView: UICollectionView!
    @IBOutlet weak var flowLayout: UICollectionViewFlowLayout!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 0
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        let itemWidth = floor(monthCollectionView.bounds.size.width / 7.0)
        flowLayout.itemSize = CGSizeMake(itemWidth, 16.0)
    }
    
    func setCollectionViewDataSourceDelegate <D: protocol<UICollectionViewDataSource, UICollectionViewDelegate>> (dataSourceDelegate: D, forMonth month: Int) {
        monthCollectionView.delegate = dataSourceDelegate
        monthCollectionView.dataSource = dataSourceDelegate
        monthCollectionView.tag = month
        monthCollectionView.reloadData()
    }

}
