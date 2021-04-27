//
//  ItemDetailViewController.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import UIKit
import SnapKit

class ItemDetailViewController: UIViewController {
    var memo: Memo?
    
    private let dataController = DataController.shared
    
    // MARK: - View
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        updateView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setupNotification()
    }
    
    private func setupView() {
        view.backgroundColor = .clubhouseBackground
        
        scrollView.alwaysBounceVertical = true
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.leading.equalTo(self.view.safeAreaLayoutGuide.snp.leading)
            make.trailing.equalTo(self.view.safeAreaLayoutGuide.snp.trailing)
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
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(imageView)
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(320)
        }
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(editDetails(edit:)))]
    }

    private func setupNotification() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(handle(reload:)),
                         name: .reloadNotificaiton,
                         object: dataController)
    }
    
    // MARK: - Action
    private func updateView() {
        title = memo?.title
        titleLabel.text = memo?.title
        descriptionLabel.text = memo?.description
        if memo?.imageID != "" {
            imageView.image = dataController.loadImage(for: memo!.imageID)
        }
    }
    
    @objc
    private func handle(reload notification: Notification) {
        updateView()
    }
    
    @objc
    func editDetails(edit button: UIBarButtonItem) {
        guard let memo = memo else { return }
        let navigation = EditItmeViewController.instantiate(with: memo)
        present(navigation, animated: true)
    }
}
