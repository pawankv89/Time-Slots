//
//  TimeCollectionCell.swift
//  Time Slots
//
//  Created by Pawan kumar on 29/03/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import UIKit

class TimeCollectionCell: UICollectionViewCell {
    
    static let identifier = "TimeCollectionCell"
    
    @IBOutlet var bgView: UIView!
    @IBOutlet var timeNowLabel: UILabel!
    
    @IBOutlet var time1Label: UILabel!
    @IBOutlet var timeToLabel: UILabel!
    @IBOutlet var time2Label: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

}
