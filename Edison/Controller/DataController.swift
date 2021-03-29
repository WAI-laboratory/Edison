//
//  DataController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit

final class DataController {
    private var preference: UserDefaults { UserDefaults.standard }
    
    static let dataKey = "cellArray"
    
    // MARK: - Data
    private(set) var data = [Memo]()
    
    // MARK: - Initialization
    init() {
        if let savedData = load() {
            data = savedData
        }
    }
    
    // MARK: - Action
    func add(item: Memo) {
        print("Add \(item) to data")
        data.append(item)
        save()
    }
    
    // MARK: - Saved data
    private func load() -> [Memo]? {
        let savedData = preference.data(forKey: Self.dataKey)
        guard let data = savedData else {
            print("No saved data")
            return nil
        }
        
        let decodedData = try? PropertyListDecoder().decode([Memo].self, from: data)
        print("Load data \(String(describing: decodedData))")
        return decodedData
    }
    
    private func save() {
        guard let encodedData = try? PropertyListEncoder().encode(data) else {
            fatalError("I DIED")
        }
        print("Save data")
        preference.set(encodedData, forKey: Self.dataKey)
    }
}
