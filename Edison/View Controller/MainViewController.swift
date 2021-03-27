//
//  MainViewController.swift
//  Edison
//
//  Created by Yongjun Lee on 2021/03/07.
//

import UIKit
import SnapKit

class MainViewController: UIViewController {
    // MARK: - Data
    private var dataController = DataController()
    let userDefaults = UserDefaults.standard

    
    // MARK: - View

    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
//        loadData()

        setup()
        setupLayout()
        updateView()

    }

    private func setup() {
        navigationItem.title = "Title"
        navigationItem.rightBarButtonItems = [UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap(add:)))]
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    

    private func setupLayout() {
        view.add(tableView) {
            $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
            $0.delegate = self
            $0.dataSource = self
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
        tableView.reloadData()
    }
    
    private func presentAddNew() {
        let addVC = AddItemViewController()
        addVC.mainVC = self
        addVC.dataController = dataController
        present(addVC, animated: true, completion: nil)
    }
}



// MARK: - Table View
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return dataController.data.count
//        return memos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(dataController.data[indexPath.row].title)"
        cell.imageView?.image = UIImage(named: "DH1")
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellVC = ItemDetailViewController()
        cellVC.value = dataController.data[indexPath.row].title
        cellVC.descriptionText = dataController.data[indexPath.row].description
        navigationController?.pushViewController(cellVC, animated: true)
    }
}


