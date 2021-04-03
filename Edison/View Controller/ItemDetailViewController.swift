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
    
    // MARK: - View
    private let scrollView = UIScrollView()
    private let stackView = UIStackView()
    private let titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let imageView = UIImageView()
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
    }
    
    private func initView() {
        title = memo?.title
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
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(imageView)
        
        titleLabel.text = memo?.title
        descriptionLabel.text = memo?.description
//        imageView.image = memo?.image
        
        imageView.contentMode = .scaleAspectFit
        imageView.snp.makeConstraints { (make) in
            make.width.equalToSuperview()
            make.height.equalTo(320)
        }
    }
}
