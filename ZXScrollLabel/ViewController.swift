//
//  ViewController.swift
//  ZXScrollLabel
//
//  Created by screson on 2018/4/19.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor.init(red: 1, green: 226 / 255.0, blue: 157 / 255.0, alpha: 1)
        let winnerList = ZXWinnerScrollView.init(origin: CGPoint(x: 30, y: 100), width: UIScreen.main.bounds.size.width - 60, pageSize: 6)
        winnerList.layer.borderColor = UIColor.orange.cgColor
        winnerList.layer.borderWidth = 1
        winnerList.reloadData(["C**抽中了JD","A**抽中了gd","A**抽中了hfd","fdsa**抽中了hf","焦呱呱抽中了iPhoneX","罗老师抽中了10万元现金红包","Once抽中了Tesla Model S","A**抽中了54元现金红包","B**抽中了Durix","GDS**抽中了gfdgfd","反对就卡萨**抽中了附近侃大山","A**抽中了1024元现金红包"])
        self.view.addSubview(winnerList)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

