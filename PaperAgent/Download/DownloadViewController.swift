//
//  DownloadViewController.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/14.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class DownloadViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    private var myTableView: UITableView!
    private let items = [
        (title: "最近使用した項目", contents: ["Digital Wing", "Amanerio", "Beat Mario"]),
        (title: "ダウンロードした項目", contents: ["Digital Wing", "Tama on the set", "Buta otome", "Beat Mario", "Amanerio"]),
        (title: "お気に入り", contents: ["Kernel", "divergence", "robust", "sparse"]),
        (title: "全ての論文", contents: ["Testaaaaaaaaaaaああああああああああああああああああああああああああああああああああああああああああ", "Test2" ]),
        ]
    private var selectFlag = Array<Bool>()
    override func viewDidLoad() {
        super.viewDidLoad()

        for _ in 0..<items.count{
            selectFlag.append(true)
        }


        // Status Barの高さを取得する.
        let barHeight: CGFloat = UIApplication.shared.statusBarFrame.size.height
        
        // TabBarの高さを取得する
        let tabBarHeight : CGFloat = (tabBarController?.tabBar.frame.size.height)!
        
        // Viewの高さと幅を取得する.
        let displayWidth: CGFloat = self.view.frame.width
        let displayHeight: CGFloat = self.view.frame.height
       
        // TableViewの生成(Status barの高さをずらして表示).
        myTableView = UITableView(frame: CGRect(x: 0, y: barHeight, width: displayWidth, height: displayHeight - tabBarHeight))
        
        // Cell名の登録をおこなう.
        myTableView.register(UITableViewCell.self, forCellReuseIdentifier: "MyCell")
        
        //罫線の削除
//        myTableView.separatorColor = UIColor.clear
        
        self.view.backgroundColor = UIColor.white
        
        // DataSourceを自身に設定する.
        myTableView.dataSource = self
        
        // Delegateを自身に設定する.
        myTableView.delegate = self
        
        myTableView.estimatedRowHeight = 50
        myTableView.estimatedSectionHeaderHeight = 50
        myTableView.rowHeight = UITableViewAutomaticDimension
        myTableView.sectionHeaderHeight = UITableViewAutomaticDimension
        
        // Viewに追加する.
        self.view.addSubview(myTableView)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //セクションのタイトルを返す
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].title as? String
    }
    
    /*
     Cellが選択された際に呼び出される
     */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(items[indexPath.section].title)
        print(items[indexPath.section].contents[indexPath.row])
        let nextView = NextViewController(title:items[indexPath.section].contents[indexPath.row])
        self.navigationController?.pushViewController(nextView, animated: true)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let a = myTableView.indexPathForSelectedRow {
            myTableView.deselectRow(at: a, animated: true)
        }
    }
    
    /*
     Cellの総数を返す.
     */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectFlag[section] ? 0 : items[section].contents.count
    }
    
    /*
     Cellに値を設定する
     */
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // 再利用するCellを取得する.
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
//        Cellに値を設定する.
        cell.textLabel?.text = items[indexPath.section].contents[indexPath.row]
        
        return cell
    }
    
    //テーブルのメイン設定
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionView : UIView = UIView()
        let label : UILabel = UILabel()
        label.text = items[section].title
        label.textColor = UIColor.blue
        label.font = UIFont(name: "Arial", size: 30)
        label.sizeToFit()
        sectionView.addSubview(label)
        sectionView.backgroundColor = UIColor.white
        
        sectionView.tag = section
        sectionView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapHeader(gestureRecognizer:))))
        
        return sectionView
    }
    
    @objc func tapHeader(gestureRecognizer : UITapGestureRecognizer){
        guard let section = gestureRecognizer.view?.tag as Int! else{
            return
        }
        self.selectFlag[section] = !self.selectFlag[section]
        self.myTableView.reloadSections(NSIndexSet(index: section) as IndexSet, with: .none)
    }
}

