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
    
    func download(url: String){
        
        let url = URL(string: url);
        let request = URLRequest(url: url!);
        let session = URLSession.shared;
        let task = session.dataTask(with: request){ (data, response, error) in
            if error == nil, let data = data, let response = response as? HTTPURLResponse{
                print("Content-Type: \(response.allHeaderFields["Content-Type"] ?? "")");
                print("statusCode: \(response.statusCode)");
//                return (String(data: data, encoding: String.Encoding.shiftJIS) ?? "");
                print(String(data: data, encoding: String.Encoding.shiftJIS) ?? "");
            }
            
        };
        task.resume();
    }
    func getAsync(downloadURL :String) {
//        print(downloadURL);
//        let urlData = URL(string: downloadURL)!
        let urlData = URL(string: "https://developer.apple.com/documentation/foundation/nsurlerrordomain")!
        let request = URLRequest(url: urlData)
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
