//
//  FileCollectionViewCell.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/17.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class FileCollectionViewCell: UICollectionViewCell {
    var textLabel : UILabel?
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // UILabelを生成.
        textLabel = UILabel(frame: CGRect(x:0, y:0, width:frame.width, height:frame.height))
        textLabel?.backgroundColor = UIColor.white
        textLabel?.layer.borderColor = UIColor.black.cgColor
        textLabel?.layer.borderWidth = 0.5
        textLabel?.layer.cornerRadius = 4
        textLabel?.textAlignment = NSTextAlignment.center
        
        // Cellに追加.
        self.contentView.addSubview(textLabel!)
    }
}
