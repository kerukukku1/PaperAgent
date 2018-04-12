//
//  MainView.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/12.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import UIKit

class MainView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    let mainLabel : UILabel
    override init(frame: CGRect) {
        self.mainLabel = UILabel()
        self.mainLabel.text = "Main Label"
        self.mainLabel.textAlignment = .center
        super.init(frame: frame)
        self.backgroundColor = UIColor.white
        self.addSubview(mainLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        let labelSize = self.mainLabel.sizeThatFits(self.bounds.size)
        
        let posX : CGFloat = (self.bounds.width - labelSize.width) / 2
        let posY : CGFloat = (self.bounds.height - labelSize.height) / 2
        let labelOrigin = CGPoint(x: posX, y: posY)
        
        self.mainLabel.frame = CGRect(origin: labelOrigin, size: labelSize)
    }
    
}
