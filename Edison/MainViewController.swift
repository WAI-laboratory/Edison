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
//        view.backgroundColor = UIColor(red: 242/255, green: 237/255, blue: 229/255, alpha: 1)
        view.backgroundColor = .red
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
//            tableView.widthAnchor.constraint(equalTo: view.widthAnchor),
//            tableView.heightAnchor.constraint(equalTo: view.heightAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
    }

    // MARK: - Action
    @objc
    func tap(button: Any) {
        guard button is UIBarButtonItem else { return }
        let tempVC = NewAddCellViewController()
//        tempVC.dc = mainDC
        present(NewAddCellViewController(), animated: true, completion: nil)
//        present(, animated: true)
//        let lastValue = cellArray.last ?? 0
//        let newValue = lastValue + 1
//        cellArray.append(newValue)
//        tableView.reloadData()
    }
}

// MARK: - Table view
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
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
