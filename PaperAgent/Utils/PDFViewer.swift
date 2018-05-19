//
//  PDFViewer.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/05/19.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class PDFViewer: UIViewController, UIWebViewDelegate{

    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.delegate = self
        let url = URL(string: "https://www.google.com")
        let request = URLRequest(url: url!)
        webView.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
