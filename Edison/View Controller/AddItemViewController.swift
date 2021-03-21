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
        view.backgroundColor = .cyan
        view.add(titleTextField) {
            $0.delegate = self
            $0.backgroundColor = .lightGray
            $0.placeholder = " title "
            $0.snp.makeConstraints { (make) in
                make.top.equalToSuperview().offset(96)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(128)
            }
         }
        view.add(descriptionTextField) {
            $0.delegate = self
            $0.backgroundColor = .purple
            $0.snp.makeConstraints { (make) in
                make.leading.trailing.bottom.equalToSuperview()
                make.top.equalTo(self.titleTextField.snp.bottom)
            }
        }
    }
}

// MARK: - TextField
extension AddItemViewController {
    // MARK: - 추후 해볼 것: 텍스트 필드 한글자 추가하는 것?
//    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
//        guard let text = titleTextField.text else { return }
//        tempStrin = dataController?.data.last
//        text + string
//        return true
//    }
    
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
