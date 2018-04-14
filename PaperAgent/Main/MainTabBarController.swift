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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        homeView = HomeViewController()
        searchView = SearchViewController()
        homeView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.recents, tag: 1)
        searchView.tabBarItem = UITabBarItem(tabBarSystemItem: UITabBarSystemItem.downloads, tag: 2)
        
        let myTabs : [UIViewController]? = [homeView!, searchView!]
        
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
