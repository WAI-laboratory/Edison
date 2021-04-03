//
//  Memo.swift
//  Edison
//
//  Created by 이용준 on 2021/03/26.
//
import UIKit
import Foundation

class Memo: Codable {
    let id = UUID().uuidString
    var title: String
    var description = ""
    
    var imageID = ""

    // MARK: - Key
    private enum CodingKeys: String, CodingKey {
        case id, title, description, imageID
    }
    
    // MARK: - Initializaation
    init(title: String) {
        self.title = title
    }
}

extension Memo: CustomDebugStringConvertible {
    var debugDescription: String {
        return "ID \(id) | \(title) \(description) | \(imageID)"
    }
}
