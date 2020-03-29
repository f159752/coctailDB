//
//  FilterTableViewViewModelType.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

protocol FilterTableViewViewModelType {
    func numberOfRows() -> Int
    func cellViewModel(forIndexPath indexPath: IndexPath) -> FilterTableViewCellViewModelType?
    
    func filterCategories(indexPaths: [IndexPath], completion: @escaping () -> ())
    func selectRowOfSelectedFilter(completion: @escaping (Int) -> ())
}
