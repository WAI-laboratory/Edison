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
    private let fileManager = FileManager()
    
    // MARK: - View
    private let tableView = UITableView(frame: .zero, style: .insetGrouped)

    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
            $0.backgroundColor = .clubhouseBackground
            
            $0.snp.makeConstraints { (make) in
                make.edges.equalToSuperview()
            }
        }
    }
    
    
    // MARK: - User interaction
    @objc
    func tap(add button: UIBarButtonItem) {
        presentAddNew()
    }

    // MARK: - Action
    func updateView() {
        tableView.reloadData()
    }
    
    private func presentAddNew() {
        let addVC = AddItemViewController()
        addVC.index = dataController.data.count
        
        addVC.mainVC = self
        addVC.dataController = dataController
        present(addVC, animated: true, completion: nil)
    }
}

// MARK: - Table View
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    // Data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataController.data.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let memo = dataController.data[indexPath.row]
        var images = [UIImage]()
        images[indexPath.row] = loadImageFromDocuments(indexPath.row)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "\(memo.title)"
//        cell.imageView?.image = memo.image
        cell.imageView?.image = images[indexPath.row]
        return cell
    }

    // Delegate
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memo = dataController.data[indexPath.row]
        let detailVC = ItemDetailViewController()
        detailVC.memo = memo
        
        navigationController?.pushViewController(detailVC, animated: true)
    }
}

// MARK: - Load image from file directory
extension MainViewController {
    func loadImageFromDocuments(_ index: Int) -> UIImage {
        do {
            let tempInt = index + 1
            let directoryPath = NSHomeDirectory().appending("/Documents/image/\(tempInt).jpg")
            let data = try Data(contentsOf: NSURL.fileURL(withPath: directoryPath))
            return UIImage(data: data) ?? UIImage()
            
            
            
        } catch {
            print(error)
        }
        return UIImage()
    }
}


extension UIColor {
    static let clubhouseBackground = UIColor(red: 241/255, green: 239/255, blue: 229/255, alpha: 1)
}
