//
//  Coctail.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation


struct CoctailsResponse: Codable {
    var drinks: [Coctail]
}

struct Coctail: Codable {
    var strDrink: String
    var strDrinkThumb: String
    var idDrink: String
}
