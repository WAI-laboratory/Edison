//
//  AddItemViewController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit

class AddItemViewController: UIViewController, UITextFieldDelegate {
    weak var mainVC : MainViewController?
    var dataController: DataController?
    var tempString = String()
    
    private let newMemo = Memo(title: "")
    
    
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let imageView = UIImageView()
    
    private let dismissButton = UIButton.dismissButton()
    private let saveButton = UIButton.saveButton()
    
    private let userDefaults = UserDefaults.standard
    private let encoder = JSONEncoder()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataController?.add(item: newMemo)
        mainVC?.updateView()

    }
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = .white
        view.add(dismissButton) {
            $0.backgroundColor = .red
            $0.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().inset(32)
                make.top.equalToSuperview().offset(32)
            }
            $0.addTarget(self, action: #selector(self.dismissNow), for: .touchUpInside)

        }
        view.add(titleTextField) {
            $0.delegate = self
            $0.backgroundColor = .lightGray
            $0.placeholder = " title "
            $0.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(32)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(64)
            }
         }
        view.add(imageView) {
            $0.image = UIImage(named: "DH1")
            $0.contentMode = .scaleAspectFit
            $0.snp.makeConstraints { (make) in
                make.top.equalTo(self.titleTextField.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(256)
            }
        }
        view.add(descriptionTextField) {
            $0.delegate = self
            $0.backgroundColor = .cyan
            $0.snp.makeConstraints { (make) in
                make.leading.trailing.bottom.equalToSuperview()
                make.top.equalTo(self.imageView.snp.bottom)
            }
        }
    }
}

// MARK: - TextField
extension AddItemViewController {
    // MARK: - 추후 해볼 것: 텍스트 필드 한글자 추가하는 것?
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text else { return }
        guard text != "" else { return }

        switch textField {
        case titleTextField:
            newMemo.title = text
        case descriptionTextField:
            newMemo.description = text
        default:
            return
        }
    }
}
//MARK: - dismiss

extension AddItemViewController {
    @objc private func dismissNow() {
        self.dismiss(animated: true, completion: nil)
    }
}
