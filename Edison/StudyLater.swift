//
//  StudyLater.swift
//  Edison
//
//  Created by 이용준 on 2021/03/13.
//

import Foundation

//        let button = UIButton()
//        button.addTarget(self, action: #selector(tap(button:)), for: .touchUpInside)
//            let main = MainViewController()
//            present(main, animated: true)
//            navigationController?.pushViewController(main, animated: true) // 푸시 새페이지



//            let main = MainViewController()
//            present(main, animated: true)
//            navigationController?.pushViewController(main, animated: true) // 푸시 새페이지
//            navigationController?.popToRootViewController(animated: true) // 루트 뷰컨으로 감
//            navigationController?.popToViewController(<#T##viewController: UIViewController##UIViewController#>, animated: <#T##Bool#>) // 특정 뷰컨으로 감



// 3/20

//    private func setupLayout() {
//        view.add(tableView) {
//            $0.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
//            $0.delegate = self
//            $0.dataSource = self
////            $0.backgroundColor = UIColor(red: 241/255, green: 239/255, blue: 229/255, alpha: 1)
//            $0.backgroundColor = .red
//            $0.snp.makeConstraints { (make) in
//                make.edges.equalToSuperview()
//            }
//        }
//    }

// MARK: - Table view
//extension MainViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
////        return mainDataController.cellIndexArray.count
//        return cellArray.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
//        cell.textLabel?.text = "\(cellArray[indexPath.row])"
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detail = ItemDetailViewController()
//        detail.value = cellArray[indexPath.row]
//        navigationController?.pushViewController(detail, animated: true)
//    }
//}


//private let tableView = UITableView(frame: .zero, style: .insetGrouped) // .zero ( CGrect zero )
//
