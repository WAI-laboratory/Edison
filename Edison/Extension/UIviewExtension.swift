//
//  UIviewExtension.swift
//  Edison
//
//  Created by Yongjun Lee on 2021/03/07.
//

import UIKit

extension UIView {
    @discardableResult
    func add<T: UIView>(_ subview: T, and closure: ((T) -> Void)? = nil) -> T {
        addSubview(subview)
        closure?(subview)
        return subview
    }
}
