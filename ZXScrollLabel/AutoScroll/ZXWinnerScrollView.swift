//
//  ZXWinnerScrollView.swift
//  ZXScrollLabel
//
//  Created by screson on 2018/4/19.
//  Copyright © 2018年 screson. All rights reserved.
//

import UIKit

class ZXWinnerScrollView: UIView {
    static let labelHeight: CGFloat = 25
    fileprivate var pageSize: Int = 6
    
    fileprivate var backContentView: UIScrollView!
    fileprivate var tblTopLabels: UITableView!
    fileprivate var tblDownLabels: UITableView!
    fileprivate var arrList: Array<String> = []
    fileprivate var currentPage = 0
    fileprivate var minTotalPage = 0
    fileprivate var totalCount = 0
    
    fileprivate var arrTopList: Array<String> = []
    fileprivate var arrDownList: Array<String> = []
    
    fileprivate var timer: Timer?
    
    
    /// init
    ///
    /// - Parameters:
    ///   - origin: origin
    ///   - width: width
    ///   - pageSize: 单页显示的条数
    convenience init(origin: CGPoint, width: CGFloat, pageSize: Int) {
        self.init(frame: CGRect(x: origin.x, y: origin.y, width: width, height: CGFloat(pageSize) * ZXWinnerScrollView.labelHeight))
        
        self.pageSize = pageSize
        backContentView = UIScrollView.init(frame: CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height))
        backContentView.contentSize = CGSize(width: width, height: frame.size.height * 2)
        backContentView.isScrollEnabled = false
        backContentView.showsVerticalScrollIndicator = false
        backContentView.showsHorizontalScrollIndicator = false
        
        tblTopLabels = UITableView.init(frame: CGRect(x: 0, y: 0, width: width, height: frame.size.height), style: .plain)
        tblTopLabels.separatorStyle = .none
        tblTopLabels.isScrollEnabled = false
        tblTopLabels.register(UINib.init(nibName: "ZXLotteryWinnerCell", bundle: nil), forCellReuseIdentifier: "ZXLotteryWinnerCell")

        tblTopLabels.delegate = self
        tblTopLabels.dataSource = self
        
        tblDownLabels = UITableView.init(frame: CGRect(x: 0, y: frame.size.height, width: width, height: frame.size.height), style: .plain)
        tblDownLabels.separatorStyle = .none
        tblDownLabels.isScrollEnabled = false
        tblDownLabels.register(UINib.init(nibName: "ZXLotteryWinnerCell", bundle: nil), forCellReuseIdentifier: "ZXLotteryWinnerCell")
        tblDownLabels.delegate = self
        tblDownLabels.dataSource = self
        
        self.backContentView.addSubview(tblTopLabels)
        self.backContentView.addSubview(tblDownLabels)
        self.addSubview(backContentView)
    }
    
    
    func reloadData(_ list: [String]) {
        self.arrList = list
        self.totalCount = self.arrList.count
        self.currentPage = 0
        self.minTotalPage = Int(ceil(Double(totalCount) / Double(pageSize)))
        
        self.timer?.invalidate()
        self.timer = nil
        self.resetted = false

        
        self.arrTopList = stringList(at: self.currentPage, resetPage: nil)
        self.arrDownList = stringList(at: self.currentPage + 1, resetPage: nil)
        
        self.tblTopLabels.reloadData()
        self.tblDownLabels.reloadData()

        
        self.checkAutoScroll()
    }
    
    fileprivate func checkAutoScroll() {
        if timer != nil {
            self.timer?.invalidate()
            self.timer = nil
        }
        
        if self.totalCount > self.pageSize { //大于一页
            timer = Timer.scheduledTimer(timeInterval: 1.3, target: self, selector: #selector(autoScrollAction), userInfo: nil, repeats: true)
            RunLoop.main.add(timer!, forMode: RunLoopMode.commonModes)
        }
    }
    
    fileprivate var resetted = false
    @objc fileprivate func autoScrollAction() {
        UIView.animate(withDuration: 1.25, animations: {
            self.backContentView.contentOffset = CGPoint(x: 0, y: self.backContentView.contentOffset.y + ZXWinnerScrollView.labelHeight)
        }) { (finished) in
            let offset = self.backContentView.contentOffset
            if offset.y == ZXWinnerScrollView.labelHeight * CGFloat(self.pageSize) {//翻页
                var index = 0
                if self.resetted {
                    self.resetted = false
                } else {
                    self.currentPage += 2
                    index = self.currentPage / 2
                }
                self.arrTopList = self.stringList(at: index, resetPage: nil)
                self.arrDownList = self.stringList(at: index + 1, resetPage: { [unowned self] (reset) in
                    if reset {
                        self.currentPage = 0
                        self.resetted = true //第n页的数据 == 第0页
                    }
                })
                self.tblTopLabels.reloadData()
                self.tblDownLabels.reloadData()
                self.backContentView.contentOffset = CGPoint.zero
            }
        }
    }
    
    /// 循环获取每一页的数据
    ///
    /// - Parameters:
    ///   - page: start from 0
    ///   - resetPage: reset to page 0
    /// - Returns: -
    fileprivate func stringList(at page: Int, resetPage: ((Bool) -> Void)?) -> [String] {
        if totalCount > 0 {
            if totalCount > pageSize {//大于一页
                var tempPage = page
                if tempPage >= minTotalPage ,(tempPage * pageSize) % totalCount == 0 {//大于最小页数，并可从第一页开始循环
                    tempPage = 0
                    resetPage?(true)
                }
                var list: Array<String> = []
                let startIndex = (tempPage * pageSize) % totalCount
                for index in startIndex..<(startIndex + pageSize) {
                    list.append(self.arrList[index % totalCount])
                }
                return list
            } else {//小于等于一页
                return self.arrList
            }
        }
        return []
    }
    
    override func didMoveToWindow() {
        super.didMoveToWindow()
        if self.window == nil {
            self.timer?.invalidate()
            self.timer = nil
        }
    }
}

extension ZXWinnerScrollView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ZXLotteryWinnerCell") as! ZXLotteryWinnerCell
        if tableView == tblTopLabels {
            cell.lbWinnerInfo.text = arrTopList[indexPath.row]
        } else {
            cell.lbWinnerInfo.text = arrDownList[indexPath.row]
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.totalCount > 0 {
            if tableView == tblTopLabels {
                return arrTopList.count
            } else {
                if self.totalCount > self.pageSize {
                    return arrDownList.count
                }
            }
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return ZXWinnerScrollView.labelHeight
    }
}
