//
//  SearchView.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/12.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var myTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let tWidth: CGFloat = 300
        let tHeight: CGFloat = 40
        let posX: CGFloat = (self.view.bounds.width - tWidth)/2
        let posY: CGFloat = 40
        
        myTextField = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
        
        myTextField.text = ""
        
        myTextField.placeholder = "ここに論文の名前を入力して下さい"
        
        myTextField.returnKeyType = UIReturnKeyType.search
        
        myTextField.delegate = self
        
        myTextField.borderStyle = .roundedRect
        
        myTextField.clearButtonMode = .whileEditing
        
        self.view.addSubview(myTextField)
    }
    
    func doSearch(){
        if myTextField.text == nil{
            return;
        }
        var text: String = "https://scholar.google.co.jp/scholar?hl=ja&as_sdt=0%2C5&q=filetype%3Apdf"
        let name: String = myTextField.text!
        var arr = name.split(separator: " ")
        for i in 0..<arr.count {
            text += "%20" + arr[i];
        }
        print(text);
        
        let url = URL(string: text);
        let request = URLRequest(url: url!);
        let session = URLSession.shared;
        let task = session.dataTask(with: request){ (data, response, error) in
            if error == nil, let data = data, let response = response as? HTTPURLResponse{
                print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")");
                print("statusCode: \(response.statusCode)");
                let html = (String(data: data, encoding: String.Encoding.shiftJIS) ?? "");
                self.makeRecordsList(html: html);
            }
            
        };
        task.resume();
        
//        requestHTTPS.getAsync(downloadURL: text)
    }
    
    func makeRecordsList(html: String){
//        print(html);
        var array1 = html.components(separatedBy: ".pdf\"");
        var i = 1;
        while true {
            if(i >= array1.count){
                break;
            }
            let pdfUrl = array1[i].components(separatedBy: "[PDF]</span></span> <a href=\"")[1] + ".pdf";
            //print(pdfUrl);
            let source = array1[i+1];
            var title = source.components(separatedBy: "amp;nossl=1\">")[1].components(separatedBy: "</h3><div class=\"gs_a\">")[0];
            title = title.replacingOccurrences(of: "<b>", with: "");
            title = title.replacingOccurrences(of: "</b>", with: "");
            title = title.replacingOccurrences(of: "</a>", with: "");
            let detail = source.components(separatedBy: "</a></h3>")[1].components(separatedBy: "<div class=\"gs_fl\">")[0];
//            print(title);
//            print(detail);
//            print(pdfUrl);
//            print("\n");
            i+=2;
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        doSearch()
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
