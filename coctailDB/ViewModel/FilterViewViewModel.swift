//
//  FilterViewViewModel.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

class FilterViewViewModel: FilterTableViewViewModelType {

    var coctailCategories: CoctailCategories?

    func numberOfRows() -> Int {
        guard let categories = coctailCategories else { return 0 }
        return categories.drinks.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FilterTableViewCellViewModelType? {
        guard let categories = coctailCategories else { return nil }
        let coctail = categories.drinks[indexPath.row]
        return FilterTableViewCellViewModel(coctailCategory: coctail)
    }
    
    func filterCategories(indexPaths: [IndexPath], completion: @escaping () -> ()){
        Storage.shared.filter(num: indexPaths) { (coctails) in
            completion()
        }
    }
    
    func selectRowOfSelectedFilter(completion: @escaping (Int) -> ()){
        for (_, item) in Storage.shared.selectedCategories.enumerated() {
            guard let index = Storage.shared.getIndexOfCategory(name: item) else { continue }
            completion(index)
        }
    }

    init() {
        coctailCategories = Storage.shared.categories
    }
    
    
}
