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
    var index = Int()
    
    private let newMemo = Memo(title: "")
    
    private let titleTextField = UITextField()
    private let descriptionTextField = UITextField()
    private let imageView = UIImageView()
    private var image = UIImage()
    
    private let dismissButton = UIButton.dismissButton()
    private let saveButton = UIButton.saveButton()
    private let photoButton = UIButton()
    
    private let userDefaults = UserDefaults.standard
    private let picker = UIImagePickerController()

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        picker.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        dataController?.add(item: newMemo)
        dataController?.assign(image: image, to: newMemo)
        mainVC?.updateView()
    }
    
    // MARK: - Setup
    private func setup() {
        view.backgroundColor = .white
        view.add(photoButton) {
            $0.setTitle("사진 찾기", for: .normal)
            $0.backgroundColor = .red
            $0.snp.makeConstraints { (make) in
                make.trailing.equalToSuperview().inset(32)
                make.top.equalToSuperview().offset(32)
                make.height.width.equalTo(64)
            }
            $0.addTarget(self, action: #selector(self.addAction), for: .touchUpInside)
        }
        
        view.add(titleTextField) {
            $0.delegate = self
            $0.backgroundColor = .lightGray
            $0.placeholder = " title "
            $0.snp.makeConstraints { (make) in
                make.top.equalTo(self.photoButton.snp.bottom)
                make.leading.trailing.equalToSuperview()
                make.height.equalTo(64)
            }
         }
        view.add(imageView) {
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
// MARK: - Action

extension AddItemViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    @objc private func dismissNow() {
        self.dismiss(animated: true, completion: nil)
    }
    @objc private func addAction() {
        let alert =  UIAlertController(title: "원하는 타이틀", message: "원하는 메세지", preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "사진앨범", style: .default) { (action) in
            self.picker.sourceType = .photoLibrary
            self.present(self.picker, animated: true, completion: nil)
            
        }
        let camera =  UIAlertAction(title: "카메라", style: .default) { (action) in
            if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
                self.picker.sourceType = .camera
                self.present(self.picker, animated: true, completion: nil)
            } else {
                fatalError()
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)
        alert.addAction(library)
//        alert.addAction(camera)
        alert.addAction(cancel)

        present(alert, animated: true, completion: nil)

    }
}
// MARK: - ImageView

extension AddItemViewController {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.image = image
            self.imageView.image = self.image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    

}
