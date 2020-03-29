//
//  CoctailCategories.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

struct CoctailCategories: Codable {
    var drinks: [Drink]
}

struct Drink: Codable {
    var strCategory: String
}
