//
//  MemoBaseEditViewController.swift
//  Edison
//
//  Created by Yongjun Lee on 2021/04/10.
//

import UIKit

class MemoBaseEditViewController: UIViewController {
    var memo = Memo(title: "")
    
    // MARK: - View
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    let titleTextField = UITextField()
    let descriptionTextField = UITextField()
    let imageView = UIImageView()
    
    private var imagePicker: UIImagePickerController?
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        saveEditedDataToMemo()
        saveMemoToDataController()
    }
    
    // MARK: - Setup
    private func setup() {
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        
        titleTextField.delegate = self
        titleTextField.placeholder = "Title"
        titleTextField.borderStyle = .roundedRect
        
        descriptionTextField.delegate = self
        descriptionTextField.placeholder = "Description"
        descriptionTextField.borderStyle = .roundedRect
        
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .gray
        imageView.isUserInteractionEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapped(image:)))
        imageView.addGestureRecognizer(tap)
    }
    
    private func setupUI() {
        view.backgroundColor = .clubhouseBackground
        
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
        
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        
        scrollView.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.right.equalToSuperview()
            make.width.equalTo(scrollView)
        }
        
        stackView.addArrangedSubview(titleTextField)
        stackView.addArrangedSubview(descriptionTextField)
        stackView.addArrangedSubview(imageView)
        imageView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(240)
        }
    }
    
    // MARK: - User Interaction
    @objc
    private func tapped(image gesture: UITapGestureRecognizer) {
        selectImageSource()
    }
    
    // MARK: - Action
    private func saveEditedDataToMemo() {
        if let text = titleTextField.text {
            memo.title = text
        }
        if let text = descriptionTextField.text {
            memo.description = text
        }
    }
    
    private func saveMemoToDataController() {
        let dataController = DataController.shared
        if dataController.memos.contains(memo) == false {
            dataController.add(item: memo)
        }
    }
    
    private func selectImageSource() {
        let alert = UIAlertController(title: "Image Source", message: nil, preferredStyle: .actionSheet)
        let photoLibrary = UIAlertAction(title: "Photo Library", style: .default)
        { [weak self] (action) in
            self?.presentImagePicker()
        }
        let camera = UIAlertAction(title: "Camera", style: .default)
        { [weak self] (action) in
            self?.presentCamera()
        }
        let cancel = UIAlertAction(title: "Cancel", style: .cancel)
        alert.addAction(photoLibrary)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert, animated: true)
    }
    
    private func presentImagePicker() {
        let picker = UIImagePickerController()
        picker.sourceType = .photoLibrary
        picker.delegate = self
        imagePicker = picker
        present(picker, animated: true)
    }
    
    private func presentCamera() {
//        if (UIImagePickerController.isSourceTypeAvailable(.camera)) {
//            self.picker.sourceType = .camera
//            self.present(self.picker, animated: true, completion: nil)
//        } else {
//            fatalError()
//        }
    }
}

// MARK: - Text Field
extension MemoBaseEditViewController: UITextFieldDelegate {
    
}

// MARK: - Image picker
extension MemoBaseEditViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var pickedImage: UIImage?
        if let image = info[.editedImage] as? UIImage {
            pickedImage = image
        } else if let image = info[.originalImage] as? UIImage {
            pickedImage = image
        }
        
        if let image = pickedImage {
            memo.image = image
            imageView.image = image
        }
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}
