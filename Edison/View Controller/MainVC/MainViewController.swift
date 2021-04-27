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
    private lazy var addButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(tap(add:)))
    
    private lazy var sortButton = UIBarButtonItem(title: "Sort", menu: sortMenu)
    private lazy var sortMenu = UIMenu(children: [
        UIAction(title: "Ascending", handler: handle(ascending:)),
        UIAction(title: "Descending", handler: handle(descending: )),
        UIAction(title: "Manual", handler: handle(manualSort:))
    ])

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
        
        navigationItem.largeTitleDisplayMode = .automatic
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.leftBarButtonItems = [editButtonItem]
        navigationItem.rightBarButtonItems = [addButton, sortButton]
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
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        tableView.setEditing(editing, animated: animated)
    }
    
    @objc
    func tap(add button: UIBarButtonItem) {
        presentAddNew()
    }
    
    @objc
    func tap(sort button: UIBarButtonItem) {
        
    }
    
    private func handle(manualSort action: UIAction) {
        if !tableView.isEditing {
            tableView.setEditing(true, animated: true)
        } else {
            tableView.setEditing(false, animated: true)
        }
    }
    
    private func handle(ascending action: UIAction) {
        dataController.sortByAscend()
        updateView()
        
    }
    
    private func handle(descending action: UIAction) {
        dataController.sortByDescend()
        updateView()
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
        // print("IMAGE \(memo.imageID)")
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
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            dataController.remove(index: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        } else if editingStyle == .insert {
        
        }
    }
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let memo = dataController.memos[sourceIndexPath.row]
        dataController.remove(index: sourceIndexPath.row)
        dataController.insert(item: memo, at: destinationIndexPath.row)

    }

    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let memo = dataController.memos[indexPath.row]
        let actionProvider: UIContextMenuActionProvider = { _ in

            let renameMenu = UIAction(title: "Rename") { _ in
                let navigation = EditItmeViewController.instantiate(with: memo)
                self.present(navigation, animated: true)
            }
            let deleteMenu = UIAction(title: "Delete", attributes: .destructive) { _ in
                self.dataController.remove(index: indexPath.row)
            }

            return UIMenu(title: memo.title, children: [
                    renameMenu,
                    deleteMenu
                ])
            }

            return UIContextMenuConfiguration(identifier: "unique-ID" as NSCopying, previewProvider: nil, actionProvider: actionProvider)
    }

}
