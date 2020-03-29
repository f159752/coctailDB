//
//  FilterViewController.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit
import SnapKit

class FilterViewController: UIViewController {
    
    private let reuseIdentifier = "Cell"
    
    var viewModel: FilterTableViewViewModelType?
    var coctailTableViewController: CoctailTableViewController!
    
    lazy var tableView = UITableView()
    lazy var applyFilterButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        viewModel = FilterViewViewModel()

        viewModel?.selectRowOfSelectedFilter(completion: { (index) in
            self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: false, scrollPosition: UITableView.ScrollPosition.top)
        })
        
        
    }
    
    @objc
    func applyFilterButtonAction(_ sender: UIButton){
        guard let viewModel = viewModel else { return }
        guard let selectedIndexPaths = tableView.indexPathsForSelectedRows else {
            viewModel.filterCategories(indexPaths: []) {
                self.coctailTableViewController.setFilterMode(value: false)
                DispatchQueue.main.async {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            return
        }
        viewModel.filterCategories(indexPaths: selectedIndexPaths) {
            self.coctailTableViewController.setFilterMode(value: true)
            DispatchQueue.main.async {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
    
    func setupUI(){
        title = "Filter"
        view.backgroundColor = .white
        
        tableView.register(FilterTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.allowsMultipleSelection = true
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        view.addSubview(applyFilterButton)
        
        tableView.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top)
            make.left.equalTo(view.snp.left)
            make.right.equalTo(view.snp.right)
            make.bottom.equalTo(applyFilterButton.snp.top)
        }
        
        applyFilterButton.setTitle("Apply Filters", for: .normal)
        applyFilterButton.backgroundColor = .white
        applyFilterButton.setTitleColor(.gray, for: .normal)
        applyFilterButton.layer.borderWidth = 1
        applyFilterButton.layer.borderColor = UIColor.gray.cgColor
        applyFilterButton.layer.cornerRadius = 10
        applyFilterButton.layer.masksToBounds = true
        applyFilterButton.snp.makeConstraints { (make) in
            make.left.equalTo(self.view.snp.left).inset(16)
            make.right.equalTo(self.view.snp.right).inset(16)
            make.bottom.equalTo(self.view.snp.bottom).inset(16)
            make.height.equalTo(50)
        }
        applyFilterButton.addTarget(self, action: #selector(applyFilterButtonAction(_:)), for: .touchUpInside)
    }
    
    
}


extension FilterViewController: UITableViewDelegate{
    
    // MARK: - Table view delegate
    
    
}

extension FilterViewController: UITableViewDataSource{
    
    // MARK: - Table view data source
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows()
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? FilterTableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
    
}
