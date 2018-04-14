//
//  HomeViewController.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/14.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let container = UIView()
        container.backgroundColor = UIColor.brown
        let button = UIButton(type: .system)
        button.setTitle("Request", for: .normal)
        button.tintColor = UIColor.white
        button.backgroundColor = UIColor.darkGray
        button.addTarget(self, action: #selector(onTappedButton(_:)), for: .touchUpInside)
        button.layer.masksToBounds = true
        button.frame = CGRect(x: self.view.frame.width/2, y: self.view.frame.height/2, width: 200, height: 50)
        self.view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func onTappedButton(_ sender : UIButton){
        print(sender)
        let path = "https://www.google.co.jp/"
        let reqSite : RequestHTTPS = RequestHTTPS()
        reqSite.getAsync(url: path)
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
