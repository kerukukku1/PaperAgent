//
//  RequestHTTP.swift
//  PaperAgent
//
//  Created by 藤野眞人 on 2018/04/14.
//  Copyright © 2018年 Mahito Fujino. All rights reserved.
//

import Foundation

class RequestHTTPS {
    init(){
        
    }
    
    func getAsync(url :String) {
        let url = URL(string: "https://qiita.com/api/v2/items?query=swift")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            do {
                let object = try JSONSerialization.jsonObject(with: data, options: [])
                print(object)
            } catch let e {
                print(e)
            }
        }
        task.resume()
    }
}
