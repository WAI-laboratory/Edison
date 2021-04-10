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
    
    private(set) var imageID = ""
    
    var image: UIImage? {
        get { DataController.shared.loadImage(for: imageID) }
        set { DataController.shared.assign(image: newValue, to: self) }
    }

    // MARK: - Key
    private enum CodingKeys: String, CodingKey {
        case id, title, description, imageID
    }
    
    // MARK: - Initializaation
    init(title: String) {
        self.title = title
    }
    
    // MARK: - Action
    func setImageID(_ id: String) {
        imageID = id
    }
}

extension Memo: Equatable {
    static func == (lhs: Memo, rhs: Memo) -> Bool {
        // left hand side / right hand side
        return lhs.id == rhs.id
    }
}

extension Memo: CustomDebugStringConvertible {
    var debugDescription: String {
        return "ID \(id) | \(title) \(description) | \(imageID)"
    }
}
