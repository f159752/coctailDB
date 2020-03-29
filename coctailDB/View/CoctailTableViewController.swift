//
//  CoctailTableViewController.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit
import MBProgressHUD

class CoctailTableViewController: UITableViewController {
    private let reuseIdentifier = "Cell"
    
    lazy var filterButton : UIBarButtonItem = {
        let b = UIBarButtonItem(image: #imageLiteral(resourceName: "filterIconEmpty").withRenderingMode(UIImage.RenderingMode.alwaysOriginal), style: .plain, target: self, action: #selector(filterButtonAction(sender:)))
        return b
    }()

    
    var viewModel: CoctailTableViewViewModelType?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Drinks"
        navigationItem.rightBarButtonItem = filterButton
        tableView.register(CoctailTableViewCell.self, forCellReuseIdentifier: reuseIdentifier)
        
        
        viewModel = CoctailTableViewViewModel()
        
        showIndicator(withTitle: "Loading", and: "fetching coctails")
        
        guard let viewModel = viewModel else { return }
        viewModel.loadCategories {
            viewModel.loadFirstCategory {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                self.hideIndicator()
            }
        }
        
        
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }

    
    func setFilterMode(value: Bool){
        guard let viewModel = viewModel else { return }
        viewModel.setFilter(value: value)
        filterButton.image = viewModel.getFilter() == true ? #imageLiteral(resourceName: "filterIconFull").withRenderingMode(UIImage.RenderingMode.alwaysOriginal) : #imageLiteral(resourceName: "filterIconEmpty").withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        tableView.reloadData()
    }
    
    @objc
    func filterButtonAction(sender: UIBarButtonItem){
        let filterViewController = FilterViewController()
        filterViewController.coctailTableViewController = self
        navigationController?.pushViewController(filterViewController, animated: true)
    }
    
    func showIndicator(withTitle title: String, and Description:String) {
        let Indicator = MBProgressHUD.showAdded(to: ((UIApplication.shared.delegate?.window)!)!, animated: true)
        Indicator.label.text = title
        Indicator.isUserInteractionEnabled = false
        Indicator.detailsLabel.text = Description
        Indicator.layer.zPosition = 2;
        self.tableView.layer.zPosition = 1;
        Indicator.show(animated: true)
    }
    func hideIndicator() {
        MBProgressHUD.hide(for: ((UIApplication.shared.delegate?.window)!)!, animated: true)
    }

    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let viewModel = viewModel else { return 0 }
        return viewModel.numberOfRows(in: section)
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? CoctailTableViewCell
        
        guard let tableViewCell = cell, let viewModel = viewModel else { return UITableViewCell() }
        let cellViewModel = viewModel.cellViewModel(forIndexPath: indexPath)
        tableViewCell.viewModel = cellViewModel
        
        return tableViewCell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let viewModel = viewModel else { return nil }
        let title = viewModel.titleForHeaderInSection(section: section)
        return title
    }

    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        guard let viewModel = viewModel else { return }
        guard let categoriesNames = Storage.shared.categories?.drinks else { return }
        let nameOfCategory = categoriesNames[indexPath.section].strCategory
        let coctails = Storage.shared.coctails
        guard let coctailsOfCategory = coctails[nameOfCategory] else { return }
        
        
        if viewModel.getFilter() == false{
            guard indexPath.section == coctails.count - 1, indexPath.row == viewModel.numberOfRows(in: indexPath.section) - 1 else { return }
            showIndicator(withTitle: "Loading", and: "fetching coctails")
            viewModel.nextPage { (success) in
                if success{
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                self.hideIndicator()
            }
        } else{
        
        }

    }
    
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
