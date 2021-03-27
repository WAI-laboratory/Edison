//
//  Memo.swift
//  Edison
//
//  Created by 이용준 on 2021/03/26.
//

import Foundation

class Memo: Codable {
    let id = UUID().uuidString
    var title: String
    var description = ""
    
//    var imageURL: URL? // FILEURL
//    var image: UIImage {
//        // get from file system
//    }
    
    
    init(title: String) {
        self.title = title
    }
}
