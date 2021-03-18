//
//  MainViewController.swift
//  Edison
//
//  Created by Yongjun Lee on 2021/03/07.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    private let tableView = UITableView(frame: .zero, style: .insetGrouped) // .zero ( CGrect zero )
    private let collectionView: UICollectionView = .detailCollectionView()
    
    private var mainDataController = DataController()
    
    private var cellArray = [1,2,3]
  

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        setupLayout()
        initView()
    

    }
    
    private func setup() {
        navigationItem.title = "Title"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap(button:)))]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        
        
    }
    
    private func setupLayout() {
        view.add(tableView) {
            $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
//            $0.backgroundColor = UIColor(red: 241/255, green: 239/255, blue: 229/255, alpha: 1)
            $0.backgroundColor = .red
            $0.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func initView() {
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

    // MARK: - Action
    @objc
    func tap(button: Any) {
        guard button is UIBarButtonItem else { return }
        cellArray.append(2)
        tableView.reloadData()
        collectionView.reloadData()
        let tempVC = NewAddCellViewController()
//        tempVC.dc = mainDC
//        present(NewAddCellViewController(), animated: true, completion: nil)
        

    }
}

// MARK: - Table view
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return mainDataController.cellIndexArray.count
        return cellArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(cellArray[indexPath.row])"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detail = CellDetailViewController()
        detail.value = cellArray[indexPath.row]
        navigationController?.pushViewController(detail, animated: true)
    }
}


// MARK: - Collection view

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "newCell", for: indexPath) as! CustomCell
        cell.titleTextView.text = "\(cellArray[indexPath.row])"
    
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
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let titleTextView = UITextView()
    
    func setupView() {
        backgroundColor = .white
        
        add(titleTextView) {
            $0.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
}
