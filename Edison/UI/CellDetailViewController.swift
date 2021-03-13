//
//  CellDetailViewController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit
import SnapKit

class CellDetailViewController: UIViewController {
    private var label = UILabel()
    
    var value: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        
    }
        
    private func initView() {
        view.backgroundColor = .yellow
        view.add(label) {
            if let resultValue = self.value {
                $0.text = "\(resultValue)"
            } else { $0.text = "nil"}
            $0.textAlignment = .center
            $0.snp.makeConstraints { (make) in
                make.trailing.leading.centerX.equalToSuperview()
                make.top.equalToSuperview().offset(180)
            }
        }
    }
    
}
