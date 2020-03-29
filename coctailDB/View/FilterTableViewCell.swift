//
//  FilterTableViewCell.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit
import SnapKit

class FilterTableViewCell: UITableViewCell {

    lazy var title = UILabel()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(title)
        title.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).inset(self.layoutMargins)
            make.bottom.equalTo(self.snp.bottom).inset(self.layoutMargins)
            make.left.equalTo(self.snp.left).inset(16)
            make.right.equalTo(self.snp.right).inset(16)
        }
        
        title.font = UIFont.systemFont(ofSize: 20.0)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    weak var viewModel: FilterTableViewCellViewModelType?{
        willSet(viewModel){
            guard let viewModel = viewModel else { return }
            title.text = viewModel.nameOfCategory
        }
    }

}
