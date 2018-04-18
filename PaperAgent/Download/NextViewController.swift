//
//  NextViewController.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/16.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class NextViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource ,UISearchResultsUpdating {
    let navTitle : String
    var showCase : UICollectionView!
    var searchRes:[String] = []
    let data:[String] = ["mato","genkyu","leo","rintao","mahito","hokekyo","freedom","huwaa","yukihiko","tom"]
    
    var searchController : UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.title = navTitle
        self.view.backgroundColor = UIColor.white
        
        searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.searchBar.sizeToFit()
        searchController.dimsBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchBar.placeholder = "検索"
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: self.view.bounds.width/3 - 8, height: self.view.bounds.width/3)
//        layout.sectionInset = UIEdgeInsetsMake(2, 0, 2, 0)
        layout.headerReferenceSize = CGSize(width: searchController.searchBar.bounds.width, height: searchController.searchBar.bounds.height)
        showCase = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        showCase.register(FileCollectionViewCell.self, forCellWithReuseIdentifier: "myCell")
        showCase.delegate = self
        showCase.dataSource = self
        showCase.backgroundColor = UIColor.lightGray
        self.view.addSubview(showCase)
        showCase.addSubview(searchController.searchBar)
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
        return (searchController.isActive) ? searchRes.count : data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : FileCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath) as! FileCollectionViewCell
        if searchController.isActive {
            cell.textLabel!.text = "\(searchRes[indexPath.row])"
        } else {
            cell.textLabel?.text = data[indexPath.row]
        }
        return cell
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        self.searchRes = data.filter({ $0.lowercased().contains(searchController.searchBar.text!.lowercased())})
        self.showCase.reloadData()
    }
    

}
