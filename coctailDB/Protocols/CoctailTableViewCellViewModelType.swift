//
//  CoctailTableViewCellViewModelType.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

protocol CoctailTableViewCellViewModelType: class {
    var coctail: Coctail { get }
}
