//
//  MyRecord.swift
//  PaperAgent
//
//  Created by 土田雄輝 on 2018/05/19.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import Foundation

class MyRecord{
    var title : String;
    var pdfURL : String;
    var detail : NSAttributedString;
    init(title_:String, pdfURL_:String, text_:NSAttributedString){
        title = title_;
        pdfURL = pdfURL_;
        detail = text_;
    }
    
}
