//
//  ViewController.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/12.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let mainView = MainView(frame: self.view.bounds)
        mainView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        self.view.addSubview(mainView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

