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
    
    // MARK: - Initialization
    init() {
        if let savedData = load() {
            data = savedData
        }
    }
    
    // MARK: - Action
    func add(item: Memo) {
        data.append(item)
        
        print("Add \(item) to data")
        
        save()
    }
    
    func reloadData() {
        print("Reload data")
    }
    
    // MARK: - User defaults
    private func load() -> [Memo]? {
        guard let encodedData = preference.data(forKey: "cellArray") else {
            fatalError()
        }
        
        let decodedData = try? PropertyListDecoder().decode([Memo].self, from: encodedData)
        print("Load data \(decodedData)")
        return decodedData
    }
    
    private func save() {
//        ["key": 1]
//        JSONEncoder() -> { "key" : 1 }
//        PropertyListEncoder() -> <key>1</key>
        
        guard let encodedData = try? PropertyListEncoder().encode(data) else {
            fatalError("I DIED")
        }
        
        preference.set(encodedData, forKey: "cellArray")
        
        print("Save data")
    }
}
