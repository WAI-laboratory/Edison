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
    
    // TODO: Save to disk
    var image: UIImage?
//    var imageURL: URL?
//    var image: UIImage? {
//
//    }

    // MARK: - Key
    private enum CodingKeys: String, CodingKey {
        case id, title, description
    }
    
    // MARK: - Initializaation
    init(title: String) {
        self.title = title
    }
}
