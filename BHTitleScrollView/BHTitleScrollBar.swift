//
//  BHTitleScrollBar.swift
//  BHTitleScrollView
//
//  Created by BigHead on 14/8/20.
//  Copyright (c) 2014年 BigHead. All rights reserved.
//

import UIKit

class BHTitleScrollBar: UIView {

    var titles: [String]!
    
    var titleLabels: [UILabel] = [UILabel]()
    
    var pageControl: UIPageControl!
    
    var defaultPage = 1
    
    var curPage: Int {
        set {
            self.pageControl.currentPage = newValue
        }
        get {
            return self.pageControl.currentPage
        }
    }
    
    init(titles: [String], frame: CGRect) {
        super.init(frame: frame)
        initTitles(titles)
        initTitleLabels()
        initPageControl()
        reloadData()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initTitles(titles: [String]) {
        self.titles = titles
    }
    
    func initPageControl() {
        self.pageControl = UIPageControl(frame: CGRectMake(0, 35, self.bounds.width, 0))
        self.pageControl.hidesForSinglePage = true
        self.pageControl.currentPage = self.defaultPage
        self.pageControl.currentPageIndicatorTintColor = UIColor(white: 0.1, alpha: 1.0)
        self.pageControl.pageIndicatorTintColor = UIColor(white: 0.8, alpha: 1.0)
        self.addSubview(self.pageControl)
    }
    
    func initTitleLabels() {
        var index = 0;
        for title: String in self.titles {
            if titleLabels.count <= index {
                var titleLabel = UILabel(frame: CGRectMake(CGFloat(100 * index), 8, self.bounds.width, 20))
                titleLabel.hidden = true
                self.titleLabels.append(titleLabel)
                self.addSubview(titleLabel)
            } else {
                var titleLabel = titleLabels[index]
                titleLabel.hidden = false
                titleLabel.autoresizingMask = .FlexibleWidth | .FlexibleTopMargin
                titleLabel.font = UIFont.boldSystemFontOfSize(17)
                titleLabel.textAlignment = .Center
                titleLabel.textColor = UIColor.darkGrayColor()
                titleLabel.backgroundColor = UIColor.clearColor()
                titleLabel.text = title
                titleLabel.alpha = (self.curPage == index) ? 1.0 : 0.0
            }
            index++
        }
    
    }
    
    func turnPage(index: Int, animated: Bool) {
        curPage = index
        setContentOffset(CGPoint(x: CGFloat(curPage) * UIScreen.mainScreen().bounds.width, y: 0), animated: animated)
    }
    
    /*
     * 重载title的滚动条
     */
    func reloadData() {
        if self.titles.count <= 0 {
            return
        }
        self.initTitleLabels()
        self.pageControl.numberOfPages = self.titleLabels.count
    }
    
    /*
     * 设置滚动条偏移量
     */
    func setContentOffset(offset: CGPoint, animated: Bool) {
        let offsetX = offset.x
        
        let screenWidth = UIScreen.mainScreen().bounds.width
        
        var index = 0;
        for titleLabel: UILabel in self.titleLabels {
            if animated {
                UIView.animateWithDuration(0.8, animations: {
                    var titleLabelFrame = titleLabel.frame
                    titleLabelFrame.origin.x = CGFloat(100 * index) - offsetX / 3.2
                    titleLabel.frame = titleLabelFrame
                    titleLabel.alpha = (offsetX < screenWidth * CGFloat(index)) ? (offsetX - screenWidth * CGFloat(index - 1)) / screenWidth : 1 - (offsetX - screenWidth * CGFloat(index)) / screenWidth
                })
            } else {
                var titleLabelFrame = titleLabel.frame
                titleLabelFrame.origin.x = CGFloat(100 * index) - offsetX / 3.2
                titleLabel.frame = titleLabelFrame
                titleLabel.alpha = (offsetX < screenWidth * CGFloat(index)) ? (offsetX - screenWidth * CGFloat(index - 1)) / screenWidth : 1 - (offsetX - screenWidth * CGFloat(index)) / screenWidth
            }
            index++
        }
    }
}
