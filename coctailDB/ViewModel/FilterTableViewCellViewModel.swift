//
//  FilterTableViewCellViewModel.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation


class FilterTableViewCellViewModel: FilterTableViewCellViewModelType{
    private var coctailCategory: Drink
    
    var nameOfCategory: String{
        return coctailCategory.strCategory
    }
    
    init(coctailCategory: Drink) {
        self.coctailCategory = coctailCategory
    }
    
}
