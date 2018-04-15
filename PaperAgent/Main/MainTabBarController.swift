//
//  MainTabBarController.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/14.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    var homeView : HomeViewController!
    var searchView : SearchViewController!
    var downloadView : DownloadViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeView = HomeViewController()
        searchView = SearchViewController()
        downloadView = DownloadViewController()
        
        homeView.navigationItem.title = "Home"
        searchView.navigationItem.title = "Search"
        downloadView.navigationItem.title = "Download"
        homeView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.recents, tag: 1)
        searchView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.search, tag: 2)
        downloadView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.downloads, tag: 3)
        
        let navController1 = UINavigationController(rootViewController: homeView)
        let navController2 = UINavigationController(rootViewController: searchView)
        let navController3 = UINavigationController(rootViewController: downloadView)
        
        let myTabs : [UIViewController] = [navController1, navController2, navController3]
        
        self.setViewControllers(myTabs, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
