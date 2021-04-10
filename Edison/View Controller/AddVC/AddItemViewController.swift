//
//  AddItemViewController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit

class AddItemViewController: MemoBaseEditViewController {
    // MARK: - Initialization
    static func instantiate() -> UINavigationController {
        let vc = AddItemViewController()
        let navigation = UINavigationController(rootViewController: vc)
        return navigation
    }

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    // MARK: - Setup
    private func setup() {
        title = "Add"
    }
}
