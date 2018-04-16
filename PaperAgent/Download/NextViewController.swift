//
//  NextViewController.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/16.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    let navTitle : String
    var showCase : UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = navTitle
        self.view.backgroundColor = UIColor.white
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width/3 - 8, height: self.view.bounds.width/3)
        layout.sectionInset = UIEdgeInsetsMake(2, 0, 2, 0)
        layout.headerReferenceSize = CGSize(width: 0, height: 0)
        showCase = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        showCase.register(FileCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        showCase.delegate = self
        showCase.dataSource = self
        self.view.addSubview(showCase)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    init(title: String){
        navTitle = title
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 55 /*tmp test size*/
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! FileCollectionViewCell
        cell.textLabel?.text = indexPath.row.description
        return cell
    }
    

}
