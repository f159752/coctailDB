//
//  CoctailTableViewViewModelType.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

protocol CoctailTableViewViewModelType {
    func numberOfSections() -> Int
    func numberOfRows(in section: Int) -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CoctailTableViewCellViewModelType?
    func titleForHeaderInSection(section: Int) -> String?
    
    func loadCategories(completion: @escaping () -> ())
    func loadCoctailByCategory(name: String, completion: @escaping () -> ())
    func loadFirstCategory(completion: @escaping () -> ())
    
    func setFilter(value: Bool)
    func getFilter() -> Bool
    
    func nextPage(completion: @escaping (Bool) -> ())
}
