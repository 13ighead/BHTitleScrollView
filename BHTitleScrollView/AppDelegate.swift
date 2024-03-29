//
//  AppDelegate.swift
//  BHTitleScrollView
//
//  Created by BigHead on 14/8/20.
//  Copyright (c) 2014年 BigHead. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UITableViewDataSource {
                            
    var window: UIWindow?
    var titleScrollViewController: BHTitleScrollViewController!

    func application(application: UIApplication!, didFinishLaunchingWithOptions launchOptions: NSDictionary!) -> Bool {
        // Override point for customization after application launch.
        var vcarr = [UIViewController]()
        for i in 0..<4 {
            let vc = UIViewController(nibName: nil, bundle: nil)
            vc.title = "page\(i)"
            var frame = window!.frame
            frame.origin.x = CGFloat(i) * frame.width
            vc.view.frame = frame
            let a = UITableView(frame: window!.frame)
            a.dataSource = self
            vc.view.addSubview(a)
            vc.view.tag = i
            println(a)
            vcarr.append(vc)
        }
        titleScrollViewController = BHTitleScrollViewController(firstPage: 0, pages: vcarr)
        window!.rootViewController = UINavigationController(rootViewController: titleScrollViewController)
        return true
    }

func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int {
println(tableView.superview?.tag)
return 50
}

func tableView(tableView: UITableView!, cellForRowAtIndexPath indexPath: NSIndexPath!) -> UITableViewCell! {
let cell = UITableViewCell(style: .Default, reuseIdentifier: "cell")
cell.textLabel.text = "\(indexPath.row)"
return cell
}

    func applicationWillResignActive(application: UIApplication!) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication!) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication!) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication!) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication!) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

}

