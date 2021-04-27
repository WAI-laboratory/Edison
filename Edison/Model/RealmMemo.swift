//
//  RealmMemo.swift
//  Edison
//
//  Created by 이용준 on 2021/04/27.
//
import UIKit
import Foundation
import RealmSwift

class RealmMemo: Object{
    dynamic var id = UUID().uuidString
    dynamic var title: String
    dynamic var detailDescription: String = ""
    dynamic private(set) var imageID = ""
    
    dynamic var image: UIImage? {
        get { DataController.shared.loadImage(for: imageID)}
        set { DataController.shared.assign(image: newValue, to: self) }
    }
    private enum CodingKeys: String, CodingKey {
        case id, title, detailDescription, imageID
    }
    
    init(title: String) {
        self.title = title
    }
    
    func setImageID(_ id: String) {
        imageID = id
    }
    
}

