//
//  BaseViewController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/27.
//

import UIKit

class BaseViewController: UIViewController {
    private let dismissButton: UIButton = .dismissButton()
    private let saveButton: UIButton = .saveButton()

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)

        modalPresentationStyle = .pageSheet
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)

        modalPresentationStyle = .pageSheet
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.add(dismissButton) {
            $0.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(32)
                make.trailing.equalToSuperview().inset(32)
            }
            $0.addTarget(self, action: #selector(self.dismiss(animated:completion:)), for: .touchUpInside)
        }
    }
    
    @objc func dismissNow() {
        self.dismiss(animated: true, completion: nil)
    }
    

}
