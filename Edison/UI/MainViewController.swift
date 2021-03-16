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
    
    private var mainDataController = DataController()
    
    private var cellArray = [1,2,3]
//    private var mainDC = DataControler()
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()

    }
    
    private func setup() {
        navigationItem.title = "Title"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap(button:)))]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func setupLayout() {
        view.add(tableView) {
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
        let tempVC = NewAddCellViewController()
//        tempVC.dc = mainDC
        present(NewAddCellViewController(), animated: true, completion: nil)

    }
}

// MARK: - Table view
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mainDataController.cellIndexArray.count
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

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
