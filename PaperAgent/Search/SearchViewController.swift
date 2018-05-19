//
//  SearchView.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/12.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    private var myTextField: UITextField!
    var myCollectionView : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        
        let tWidth: CGFloat = 340
        let tHeight: CGFloat = 40
        let posX: CGFloat = (self.view.bounds.width - tWidth)/2
        let posY: CGFloat = 34
        
        myTextField = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
        
        myTextField.text = ""
        
        myTextField.placeholder = "ここに論文の名前を入力して下さい"
        
        myTextField.returnKeyType = UIReturnKeyType.search
        
        myTextField.delegate = self
        
        myTextField.borderStyle = .roundedRect
        
        myTextField.clearButtonMode = .whileEditing
        
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width:self.view.bounds.width, height:170);
        layout.sectionInset = UIEdgeInsets.zero;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.headerReferenceSize = CGSize(width:100, height:0);
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout);
        myCollectionView.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell");
        myCollectionView.delegate = self;
        myCollectionView.dataSource = self;
        myCollectionView.backgroundColor = UIColor.white;
        
        myCollectionView.frame = CGRect(x:0, y:90, width:self.view.bounds.width, height:self.view.bounds.height - 100);
        
        let bottomBorder = UIView();
        let borderWidth = CGFloat(2.0) // <- 線の太さ
        bottomBorder.frame = CGRect(x:0, y:90, width:self.view.bounds.width, height:borderWidth)
        bottomBorder.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // <- 線の色
        
        
        self.view.addSubview(myCollectionView);
        self.view.addSubview(myTextField);
        self.view.addSubview(bottomBorder);
    }
    
    func doSearch(){
        if myTextField.text == nil{
            return;
        }
        var text: String = "https://scholar.google.co.jp/scholar?as_vis=1&hl=ja&as_sdt=0%2C5&q=filetype%3Apdf"
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
    
    
    var recordList : [MyRecord] = [];
    
    func makeRecordsList(html: String){
        print(html);
        recordList.removeAll();
        var array1 = html.components(separatedBy: ".pdf\"");
        var i = 1;
        while true {
            if(i >= array1.count){
                break;
            }
            let pdfUrl = array1[i].components(separatedBy: "]</span></span> <a href=\"")[1] + ".pdf";
            //print(pdfUrl);
            let source = array1[i+1];
            var title = source.components(separatedBy: "amp;nossl=1\">")[1].components(separatedBy: "</h3><div class=\"gs_a\">")[0];
            title = title.replacingOccurrences(of: "<b>", with: "");
            title = title.replacingOccurrences(of: "</b>", with: "");
            title = title.replacingOccurrences(of: "</a>", with: "");
            let detail = source.components(separatedBy: "</a></h3>")[1].components(separatedBy: "<div class=\"gs_fl\">")[0];
            print(title);
            print(detail);
            print(pdfUrl);
            print("\n");
            recordList.append(MyRecord(title_: title, pdfURL_: pdfUrl, text_: detail));
            i+=2;
        }
        print(recordList.count);
        DispatchQueue.main.async {
            self.myCollectionView.reloadData();
        }
//        myCollectionView.reloadData();
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("CHECK! \(recordList.count)");
        return recordList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomUICollectionViewCell;
        cell.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor;
        cell.layer.borderWidth = 0.4;
        cell.titleLabel?.text = recordList[indexPath.row].title;
        cell.detailLabel?.attributedText = recordList[indexPath.row].text.htmlToAttributedString(family: "Helvetica", size: 8.0);
        cell.detailLabel?.numberOfLines = 0;
        cell.detailLabel?.sizeToFit();
        if(indexPath.row % 2 == 1){
            cell.setDarker();
        }else{
            cell.setLighter();
        }
        return cell;
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
