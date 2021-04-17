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
    private let dataController = DataController.shared
    private let fileManager = FileManager()
    
    // MARK: - View
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupLayout()
        setupNotification()
        updateView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
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
            $0.backgroundColor = .clubhouseBackground
            
            $0.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
    private func setupNotification() {
        NotificationCenter.default
            .addObserver(self,
                         selector: #selector(handle(reload:)),
                         name: .reloadNotificaiton,
                         object: dataController)
    }
    
    // MARK: - User interaction
    @objc
    func tap(add button: UIBarButtonItem) {
        presentAddNew()
    }

    // MARK: - Action
    private func updateView() {
        tableView.reloadData()
    }
    
    @objc
    private func handle(reload notification: Notification) {
        updateView()
    }
    
    private func presentAddNew() {
        let vc = AddItemViewController.instantiate()
        present(vc, animated: true)
    }
}

// MARK: - Table View
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.memos.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memo = dataController.memos[indexPath.row]
         
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(memo.title)"
        print("IMAGE \(memo.imageID)")
        if memo.imageID != "" {
            cell.imageView?.image = dataController.loadImage(for: memo.imageID)
        }

        return cell
    }

    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memo = dataController.memos[indexPath.row]
        let detailVC = ItemDetailViewController()
        detailVC.memo = memo
        
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}


extension UIColor {
    static let clubhouseBackground = UIColor(red: 241/255, green: 239/255, blue: 229/255, alpha: 1)
}
