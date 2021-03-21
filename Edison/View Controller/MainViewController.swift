//
//  MainViewController.swift
//  Edison
//
//  Created by Yongjun Lee on 2021/03/07.
//

import UIKit
import SnapKit

class MainViewController: UIViewController, UITableViewDelegate {
    // MARK: - Data
    private var dataController = DataController()
    let myUserDefaults = UserDefaults.standard
    
    // MARK: - View
    private let collectionView: UICollectionView = .detailCollectionView()
  

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
        dataController.reloadData()
    }

    private func setup() {
        navigationItem.title = "Title"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap(add:)))]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func setupLayout() {
        view.add(collectionView) {
            $0.dataSource = self
            $0.delegate = self
            $0.register(CustomCell.self, forCellWithReuseIdentifier: "newCell")
            $0.backgroundColor = UIColor(red: 241/255, green: 239/255, blue: 229/255, alpha: 1)
            $0.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
    // MARK: - User interaction
    @objc
    func tap(add button: UIBarButtonItem) {
//        cellArray.append(2)
//        tableView.reloadData()
//        collectionView.reloadData()
//        let tempVC = AddItemViewController()
//        tempVC.dc = mainDC
        presentAddNew()
    }

    // MARK: - Action
    func updateView() {
        dataController.reloadData()
        collectionView.reloadData()
    }
    
    private func presentAddNew() {
        let addVC = AddItemViewController()
        addVC.mainVC = self
        addVC.dataController = dataController
        present(addVC, animated: true, completion: nil)
    }
}



// MARK: - Collection view

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataController.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath) as! CustomCell
        cell.titleLabel.text = "\(dataController.data[indexPath.row].title)"
        cell.descriptionLabel.text = "\(dataController.data[indexPath.row].description)"
        cell.backgroundColor = .red
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width
        let size = CGSize(width: width, height: 60)
        return size
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cellVC = ItemDetailViewController()
        cellVC.value = dataController.data[indexPath.row].title
        navigationController?.pushViewController(cellVC, animated: true)
    }
}
// MARK: - UIExtension

private extension UIView {
    static func detailCollectionView() -> UICollectionView {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.sectionInset = .init(top: 0, left: 0, bottom: 16, right: 0)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return collectionView
    }
}


class CustomCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        initView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    
    func initView() {
        add(titleLabel) {
            $0.backgroundColor = .blue
            $0.snp.makeConstraints { (make) in
                make.top.equalToSuperview()
                make.leading.equalToSuperview().offset(64)
                make.trailing.equalToSuperview().inset(64)
                make.height.equalTo(40)
            }
        }
        add(descriptionLabel) {
            $0.backgroundColor = .green
            $0.snp.makeConstraints { (make) in
                make.top.equalTo(self.titleLabel.snp.bottom)
                make.leading.equalToSuperview().offset(64)
                make.trailing.equalToSuperview().inset(64)
                make.bottom.equalToSuperview()
            }
        }
    }
}
