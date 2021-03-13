//
//  NewAddCellViewController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit

class NewAddCellViewController: UIViewController, UITextFieldDelegate {
    private let textField = UITextField()
//    var dc: DataControler?

    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    
    private func initView() {
        view.backgroundColor = .cyan
        view.add(textField) {
            $0.backgroundColor = .white
            $0.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(100)
                make.bottom.leading.trailing.equalToSuperview()
                
                
            
            }
        }
    }
    
    
}

// MARK: - TextField
extension NewAddCellViewController {
    
    
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
//        tempStr = textField.text!
//        print(tempStr)
    }
    
}
