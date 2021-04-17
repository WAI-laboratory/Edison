//
//  EditItemViewController.swift
//  Edison
//
//  Created by Yongjun Lee on 2021/04/10.
//

import UIKit
import SnapKit
//import CoreData

class EditItmeViewController: MemoBaseEditViewController {
    weak var detailVC : ItemDetailViewController?
    

    
    // MARK: - Initialization
    static func instantiate(with memo: Memo) -> UINavigationController {
        let vc = EditItmeViewController()
        vc.memo = memo
        
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
        title = "Edit"
        
        titleTextField.text = memo.title
        descriptionTextField.text = memo.description
        imageView.image = memo.image
    }
}
