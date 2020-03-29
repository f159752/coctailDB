//
//  CoctailTableViewCell.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage

class CoctailTableViewCell: UITableViewCell {

    lazy var coctailImageView = UIImageView()
    lazy var title = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(coctailImageView)
        self.addSubview(title)
        
        coctailImageView.snp.makeConstraints { (make) in
            make.top.equalTo(self.snp.top).inset(self.layoutMargins)
            make.left.equalTo(self.snp.left).inset(self.layoutMargins)
            make.bottom.equalTo(self.snp.bottom).inset(self.layoutMargins)
            make.width.height.equalTo(50)
        }
        
        title.snp.makeConstraints { (make) -> Void in
            make.top.equalTo(self.snp.top).inset(self.layoutMargins)
            make.bottom.equalTo(self.snp.bottom).inset(self.layoutMargins)
            make.left.equalTo(self.coctailImageView.snp.right).offset(16)
            make.right.equalTo(self.snp.right).inset(self.layoutMargins)
        }
        
        title.font = UIFont.systemFont(ofSize: 18.0)
        title.numberOfLines = 0
        coctailImageView.contentMode = .scaleAspectFill

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    weak var viewModel: CoctailTableViewCellViewModelType?{
        willSet(viewModel){
            guard let viewModel = viewModel, let url = URL(string: viewModel.coctail.strDrinkThumb) else { return }
            title.text = viewModel.coctail.strDrink
            coctailImageView.sd_setImage(with: url, placeholderImage: #imageLiteral(resourceName: "noPhoto"))
        }
    }

}
