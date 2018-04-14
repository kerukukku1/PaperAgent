//
//  DownloadViewController.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/14.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    private let dlContents : NSArray = ["Robust","Sparse","Kernel"]
    private var dlTable : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let barHeight : CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        let displayWidth : CGFloat = self.view.frame.width
        let displayHeight : CGFloat = self.view.frame.height
        
        dlTable = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight))
        dlTable.register(UITableViewCell.self, forCellReuseIdentifier: "myCell")
        dlTable.dataSource = self
        dlTable.delegate = self
        self.view.addSubview(dlTable)
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Num: \(indexPath.row)")
        print("Value: \(dlContents[indexPath.row])")
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dlContents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath as IndexPath)
        cell.textLabel!.text = "\(dlContents[indexPath.row])"
        return cell
    }
    
    
}

