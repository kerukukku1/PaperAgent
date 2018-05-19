//
//  PDFViewer.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/05/19.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit
import WebKit

class PDFViewer: UIViewController{
    let wkWebView = WKWebView()
    var backButton: UIButton!
    var forwadButton: UIButton!
    var progressView = UIProgressView()
    var targetUrl = "https://google.co.jp/"
    
    func setTargetURL(path: String){
        self.targetUrl = path;
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        wkWebView.frame = view.frame
        wkWebView.navigationDelegate = self
        wkWebView.uiDelegate = self
        
        self.progressView = UIProgressView(frame: CGRect(x: 0.0, y: (self.navigationController?.navigationBar.frame.size.height)! - 3.0, width: self.view.frame.size.width, height: 3.0))
        self.progressView.progressViewStyle = .bar
        self.navigationController?.navigationBar.addSubview(self.progressView)
        
        // KVO 監視
        self.wkWebView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        self.wkWebView.addObserver(self, forKeyPath: "loading", options: .new, context: nil)
        
        // スワイプでの「戻る・すすむ」を有効にする
        wkWebView.allowsBackForwardNavigationGestures = true
        
        let urlRequest = URLRequest(url:URL(string:targetUrl)!)
        wkWebView.load(urlRequest)
        view.addSubview(wkWebView)
        
        createWebControlParts()
        
    }
    
    deinit {
        self.wkWebView.removeObserver(self, forKeyPath: "estimatedProgress", context: nil)
        self.wkWebView.removeObserver(self, forKeyPath: "loading", context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            // alphaを1にする(表示)
            self.progressView.alpha = 1.0
            // estimatedProgressが変更されたときにプログレスバーの値を変更
            self.progressView.setProgress(Float(self.wkWebView.estimatedProgress), animated: true)
            
            // estimatedProgressが1.0になったらアニメーションを使って非表示にしアニメーション完了時0.0をセットする
            if (self.wkWebView.estimatedProgress >= 1.0) {
                UIView.animate(withDuration: 0.3,
                               delay: 0.3,
                               options: [.curveEaseOut],
                               animations: { [weak self] in
                                self?.progressView.alpha = 0.0
                    }, completion: {
                        (finished : Bool) in
                        self.progressView.setProgress(0.0, animated: false)
                })
            }
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /// 戻る・すすむボタン作成
    private func createWebControlParts() {
        
        let buttonSize = CGSize(width:40,height:40)
        let offseetUnderBottom:CGFloat = 60
        let yPos = (UIScreen.main.bounds.height - offseetUnderBottom)
        let buttonPadding:CGFloat = 10
        
        let backButtonPos = CGPoint(x:buttonPadding, y:yPos)
        let forwardButtonPos = CGPoint(x:(buttonPadding + buttonSize.width + buttonPadding), y:yPos)
        
        backButton = UIButton(frame: CGRect(origin: backButtonPos, size: buttonSize))
        forwadButton = UIButton(frame: CGRect(origin:forwardButtonPos, size:buttonSize))
        
        backButton.setTitle("<", for: .normal)
        backButton.setTitle("< ", for: .highlighted)
        backButton.setTitleColor(.white, for: .normal)
        backButton.layer.backgroundColor = UIColor.black.cgColor
        backButton.layer.opacity = 0.6
        backButton.layer.cornerRadius = 5.0
        backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        backButton.isHidden = true
        view.addSubview(backButton)
        
        forwadButton.setTitle(">", for: .normal)
        forwadButton.setTitle(" >", for: .highlighted)
        forwadButton.setTitleColor(.white, for: .normal)
        forwadButton.layer.backgroundColor = UIColor.black.cgColor
        forwadButton.layer.opacity = 0.6
        forwadButton.layer.cornerRadius = 5.0
        forwadButton.addTarget(self, action: #selector(goForward), for: .touchUpInside)
        forwadButton.isHidden = true
        view.addSubview(forwadButton)
        
    }
    
    @objc private func goBack() {
        wkWebView.goBack()
    }
    
    @objc private func goForward() {
        wkWebView.goForward()
    }
}
extension PDFViewer: WKNavigationDelegate {
    
    // ウェブのロード完了時に呼び出される
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        backButton.isHidden = (webView.canGoBack) ? false : true
        forwadButton.isHidden = (webView.canGoForward) ? false : true
    }
}

// target=_blank対策
extension PDFViewer: WKUIDelegate {
    
    func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration,
                 for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        
        if navigationAction.targetFrame == nil {
            webView.load(navigationAction.request)
        }
        
        return nil
    }
    
}
