//
//  SearchView.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/12.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController, UITextFieldDelegate, UICollectionViewDelegate, UICollectionViewDataSource, UIScrollViewDelegate {
    
    

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
        
        let tabBarController: UITabBarController = UITabBarController()
        let tabBarHeight = tabBarController.tabBar.frame.size.height
        
        let tWidth: CGFloat = 340
        let tHeight: CGFloat = 40
        let posX: CGFloat = (self.view.bounds.width - tWidth)/2
        let posY: CGFloat = 34 + tabBarHeight;
        
        myTextField = UITextField(frame: CGRect(x: posX, y: posY, width: tWidth, height: tHeight))
        
        myTextField.text = ""
        
        myTextField.placeholder = "ここに論文の名前を入力して下さい"
        
        myTextField.returnKeyType = UIReturnKeyType.search
        
        myTextField.delegate = self
        
        myTextField.borderStyle = .roundedRect
        
        myTextField.clearButtonMode = .whileEditing
        
        let layout = UICollectionViewFlowLayout();
        layout.itemSize = CGSize(width:self.view.bounds.width, height:180);
        layout.sectionInset = UIEdgeInsets.zero;
        layout.minimumLineSpacing = 0.0;
        layout.minimumInteritemSpacing = 0.0;
        layout.headerReferenceSize = CGSize(width:100, height:0);
        myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout);
        myCollectionView.register(CustomUICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell");
        myCollectionView.delegate = self;
        myCollectionView.dataSource = self;
        myCollectionView.backgroundColor = UIColor.white;
        
        (myCollectionView as UIScrollView).delegate = self;
        
        myCollectionView.frame = CGRect(x:0, y:90 + tabBarHeight, width:self.view.bounds.width, height:self.view.bounds.height - 100 - tabBarHeight);
        
        let bottomBorder = UIView();
        let borderWidth = CGFloat(2.0) // <- 線の太さ
        bottomBorder.frame = CGRect(x:0, y:90 + tabBarHeight, width:self.view.bounds.width, height:borderWidth)
        bottomBorder.backgroundColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1) // <- 線の色
        
        
        self.view.addSubview(myCollectionView);
        self.view.addSubview(myTextField);
        self.view.addSubview(bottomBorder);
    }
    
    func doSearch(keyword : String, page : Int){
        var text: String = "https://scholar.google.co.jp/scholar?as_vis=1&start=\((page-1) * 10)&hl=ja&as_sdt=0%2C5&q=filetype%3Apdf"
        let name: String = keyword;
        var arr = name.split(separator: " ")
        for i in 0..<arr.count {
            text += "%20" + arr[i].addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!;
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
                self.makeRecordsList(html: html, isFirst: page==1);
            }else{
                self.viewdPage -= 1;
            }
            
        };
        task.resume();
    }
    
    
    var recordList : [MyRecord] = [];
    var lastViewd : Int = -1;
    var viewdPage : Int = 0;
    var searchKeyword : String? = nil;
    
    func makeRecordsList(html: String, isFirst : Bool){
        print(html);
        if(isFirst){
            recordList.removeAll();
            lastViewd = -1;
        }
        var array1 = html.components(separatedBy: "関連記事");
        var i = 0;
        while true {
            if(i >= array1.count - 1){
                break;
            }
            let array2 = array1[i].components(separatedBy: "\" class=\"gs_or_mor\" role=\"");
            let data = array2[array2.count - 1];
            let array3 = data.components(separatedBy: ".pdf");
            if(array3.count == 0 || array3.count == 1){i+=1;continue;}
            let array4 = array3[0].components(separatedBy: "href=\"");
            let pdfUrl = array4[array4.count - 1] + ".pdf";
            print(pdfUrl);
            let array5 = data.components(separatedBy: "amp;nossl=1\">");
            var title = "";
            if(array5.count == 2){
                title = array5[1].components(separatedBy: "</h3><div class=\"gs_a\">")[0]
            }else{
                title = array5[2].components(separatedBy: "</h3><div class=\"gs_a\">")[0]
            }
            title = title.replacingOccurrences(of: "<b>", with: "");
            title = title.replacingOccurrences(of: "</b>", with: "");
            title = title.replacingOccurrences(of: "</a>", with: "");
            let detail = data.components(separatedBy: "</a></h3>")[1].components(separatedBy: "<div class=\"gs_fl\">")[0].htmlToAttributedString(family: "Helvetica", size: 10.0);
            print(title);
//            print(detail);
            print(pdfUrl);
            print("\n");
            recordList.append(MyRecord(title_: title, pdfURL_: pdfUrl, text_: detail!, row_: recordList.count));
            i+=1;
        }
        print(recordList.count);
        DispatchQueue.main.async {
            self.myCollectionView.reloadData();
        }
//        myCollectionView.reloadData();
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("\(lastViewd) , \(recordList.count)");
//        if(lastViewd != recordList.count - 1){return;}
        if(searchKeyword == nil){return;}
        let visibles = myCollectionView.visibleCells;
        var flag : Bool = false;
        for i in 0..<visibles.count {
            if((visibles[i] as! CustomUICollectionViewCell).row == recordList.count-1){flag = true;}
        }
        if(flag == false){return;}
        viewdPage += 1;
        doSearch(keyword: searchKeyword!, page: viewdPage);
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let pdfURL : String = recordList[indexPath.row].pdfURL;
        let vc = PDFViewer()
        vc.setTargetURL(path: pdfURL)
        self.navigationController?.pushViewController(vc, animated: true)

    }

    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("CHECK! \(recordList.count)");
        return recordList.count;
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CustomUICollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyCell", for: indexPath) as! CustomUICollectionViewCell;
        cell.layer.borderColor = UIColor(red: 0.8, green: 0.8, blue: 0.8, alpha: 1).cgColor;
        cell.layer.borderWidth = 0.4;
        cell.setTitle(title: recordList[indexPath.row].title);
        cell.setDetail(detail: recordList[indexPath.row].detail);
        cell.resize();
        cell.setRow(row_: recordList[indexPath.row].row);
        if(indexPath.row % 2 == 1){
            cell.setDarker();
        }else{
            cell.setLighter();
        }
        lastViewd = indexPath.row;
        return cell;
    }
       
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! UICollectionViewCell
        cell.backgroundColor = UIColor(red: 230 / 255, green: 230 / 255, blue: 230 / 255, alpha: 1);
//        print("Dark \(indexPath.row)");
    }
    
    func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
//        print("Light \(indexPath.row)");
        UIView.animate(withDuration: 0.4) {
            if let cell = collectionView.cellForItem(at: indexPath) as? CustomUICollectionViewCell {
                if(indexPath.row % 2 == 1){
                    cell.setDarker();
//                    print("Darker");
                }else{
                    cell.setLighter();
//                    print("Lighter");
                }
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        if myTextField.text == nil{
            return false;
        }
        searchKeyword = myTextField.text;
        viewdPage = 1;
        textField.resignFirstResponder()
        doSearch(keyword: myTextField.text!, page: 1)
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}
