//
//  BHTitleScrollViewController.swift
//  BHTitleScrollView
//
//  Created by BigHead on 14/8/20.
//  Copyright (c) 2014年 BigHead. All rights reserved.
//

import UIKit

class BHTitleScrollViewController: UIViewController, UIScrollViewDelegate {

    var curPage: Int! = 0
    
    var pageScrollView: UIScrollView!
    
    var titleScrollBar: BHTitleScrollBar!
    
    var pages = [UIViewController]()
    
    init(firstPage: Int!, pages: [UIViewController]!) {
        super.init(nibName: nil, bundle: nil)
        curPage = firstPage
        self.pages = pages
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
//++++++
//        initPages()
//        initGesture()
//++++++
        initPageScrollView()
        initTitleScrollBar()
    }
    
    func initPages() {
        let curView = pages[curPage].view
        view.addSubview(curView)
    }
    func initGesture() {
        let swipeGestureRight = UISwipeGestureRecognizer(target: self, action: "didSwipeGesture:")
        swipeGestureRight.direction = .Right
        view.addGestureRecognizer(swipeGestureRight)
        
        let swipeGestureLeft = UISwipeGestureRecognizer(target: self, action: "didSwipeGesture:")
        swipeGestureLeft.direction = .Left
        view.addGestureRecognizer(swipeGestureLeft)
    
    }
    
    func didSwipeGesture(swipeGestureRecognizer: UISwipeGestureRecognizer) {
        if swipeGestureRecognizer.direction == .Left {
            if curPage >= pages.count - 1 {
                return
            }
            view.addSubview(pages[curPage+1].view)
            pages[curPage+1].view.frame = CGRectMake(view.frame.width, 0, view.frame.width, view.frame.height)
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(.EaseIn)
            pages[curPage].view.frame = CGRectMake(-view.frame.width, 0, view.frame.width, view.frame.height)
            pages[curPage+1].view.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
            pages[curPage].view.removeFromSuperview()
            curPage = curPage + 1
        } else if swipeGestureRecognizer.direction == .Right {
            if curPage <= 0 {
                return
            }
            view.addSubview(pages[curPage-1].view)
            pages[curPage - 1].view.frame = CGRectMake(-view.frame.width, 0, view.frame.width, view.frame.height)
            UIView.beginAnimations(nil, context: nil)
            UIView.setAnimationCurve(.EaseIn)
            pages[curPage].view.frame = CGRectMake(view.frame.width, 0, view.frame.width, view.frame.height)
            pages[curPage].view.removeFromSuperview()
            pages[curPage - 1].view.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
            curPage = curPage - 1
        }
        self.titleScrollBar.turnPage(self.curPage, animated: true)
    
    }
    
    //+++++++++
    
    /*
     *初始化页面容器
     */
    func initPageScrollView() {
        let offsetY = self.navigationController.navigationBar.frame.height
        pageScrollView = UIScrollView()
        pageScrollView.frame = CGRectMake(0, 0, view.frame.width, view.frame.height)
        pageScrollView.contentSize = CGSizeMake(self.pageScrollView.bounds.width * 4.0, 0)
        pageScrollView.delegate = self
        pageScrollView.bounces = false
        pageScrollView.pagingEnabled = true
        pageScrollView.scrollsToTop = false
        pageScrollView.showsHorizontalScrollIndicator = false
        pageScrollView.showsVerticalScrollIndicator = false

        for i: UIViewController in pages {
            pageScrollView.addSubview(i.view)
        }
        view.addSubview(pageScrollView)
    }
    
    /*
     *初始化顶部滚动条
     */
    func initTitleScrollBar() {
        UINavigationBar.appearance().barTintColor = UIColor(red: 0.291, green: 0.607, blue: 1.000, alpha: 1.000)
        UINavigationBar.appearance().tintColor = UIColor(red: 0.291, green: 0.607, blue: 1.000, alpha: 1.000)
        UINavigationBar.appearance().titleTextAttributes = NSDictionary(objectsAndKeys: UIColor.darkGrayColor(), NSForegroundColorAttributeName, UIFont.boldSystemFontOfSize(17), NSFontAttributeName)
        var titles = [String]()
        for i in pages {
            titles.append(i.title)
        }
        self.titleScrollBar = BHTitleScrollBar(titles: titles, frame: CGRectMake(0, 0, self.view.bounds.width / 2.0, 44))
        self.navigationItem.titleView = self.titleScrollBar
        self.navigationItem.titleView.backgroundColor = UIColor.clearColor()
    }
    
    /*
     *设置当前显示页面
     */
    func setCurrentPage(index: Int, animated: Bool) {
        self.titleScrollBar.curPage = index
        self.curPage = index
        
        let pageWidth = self.pageScrollView.frame.width
        self.pageScrollView.setContentOffset(CGPointMake(pageWidth * CGFloat(index), 0), animated: animated)
    }
    
    //MARK: UIScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView!) {
        self.titleScrollBar.setContentOffset(scrollView.contentOffset, animated: true)
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView!) {
        let pageWidth = self.pageScrollView.frame.width
        self.curPage = Int(floor( (scrollView.contentOffset.x - pageWidth / 2.0 ) / pageWidth) + 1)
        self.titleScrollBar.turnPage(self.curPage, animated: true)
        scrollView.contentOffset.x = pageWidth * CGFloat(curPage)
    }
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView!) {
        let pageWidth = self.pageScrollView.frame.width
        self.curPage = Int(floor( (scrollView.contentOffset.x - pageWidth / 2.0 ) / pageWidth) + 1)
        self.titleScrollBar.turnPage(self.curPage, animated: true)
        scrollView.contentOffset.x = pageWidth * CGFloat(curPage)
    }
}
