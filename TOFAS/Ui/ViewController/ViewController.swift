//
//  ViewController.swift
//  TOFAS
//
//  Created by Mac on 24.01.2024.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = TableViewViewModel()
    let refreshControl = UIRefreshControl()
    var isLoading = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getListData { isCompleted in
            if isCompleted {
                self.tableView.reloadData()
            }
        }
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "MainTableViewCell", bundle: nil), forCellReuseIdentifier: "reusableID")
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshData), for: .valueChanged)
    }
    
    @objc func refreshData() {
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
}

// MARK: - TableViewDelegate Method
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "reusableID", for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        let post = viewModel.getOnePost(indexpath: indexPath.row)
        cell.titleLabel.text = post.title
        cell.bodyLabel.text = post.body
        return cell
    }
}

//MARK: - ScrollViewDelegate Method
extension ViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height

        if offsetY > contentHeight - screenHeight && !isLoading {
            isLoading = true
            print("Burada daha fazla veri yüklenmesi gerekir veri yüklemesi bittikten sonra isLoading tekrar false konumuna getirilir.")
        }
    }
}
