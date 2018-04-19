//
//  ZXLotteryWinnerCell.swift
//  YDY_GJ_3_5
//
//  Created by screson on 2018/4/18.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXLotteryWinnerCell: UITableViewCell {

    @IBOutlet weak var lbWinnerInfo: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.backgroundColor = UIColor.init(red: 1, green: 226 / 255.0, blue: 157 / 255.0, alpha: 1)
        self.selectionStyle = .none
        self.lbWinnerInfo.textColor = UIColor.init(red: 170 / 255.0, green: 126 / 255.0, blue: 42 / 255.0, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
