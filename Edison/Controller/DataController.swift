//
//  DataController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit

class DataController {
    var data = [Memo]()
    
    
    private let preference = UserDefaults.standard
    
    func add(item: Memo) {
        data.append(item)
//        preference.set(data, forKey: "cellArray")
    }
    
    func reloadData() {
//        data = preference.array(forKey: "cellArray") as? [Memo] ?? [Memo]()
    }
}

class Memo {
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

//0. Table view
//1. Codable, JSONEncoder -> memo save to userdefault
//2. Detail view -> Show description, image
//3. Add New -> Select image from photo library ( or camera or file)
//4. Image -> Save to file system,
//5. Image retrive from file system
//6. Reorder, rename, edit, delete
