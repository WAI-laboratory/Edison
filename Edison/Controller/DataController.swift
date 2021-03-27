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
