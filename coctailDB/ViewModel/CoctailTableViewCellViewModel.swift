//
//  CoctailTableViewCellViewModel.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation

class CoctailTableViewCellViewModel: CoctailTableViewCellViewModelType{
    private var _coctail: Coctail
    
    var coctail: Coctail{
        return _coctail
    }

    init(coctail: Coctail) {
        self._coctail = coctail
    }
}
