//
//  CoctailTableViewViewModel.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation
import Moya

class CoctailTableViewViewModel: CoctailTableViewViewModelType {
    private var currentPage: Int {
        let coctailsOfCategory = Storage.shared.coctails.count
        return coctailsOfCategory
    }
    private var maxPage: Int{
        if isFilter{
            return Storage.shared.selectedCategories.count
        }else{
            guard let categories = Storage.shared.categories?.drinks else { return 0 }
            return categories.count
        }
    }
    
    var isFilter = false
    var isLoad = false
    
    func setFilter(value: Bool){
        isFilter = value
    }
    func getFilter() -> Bool{
        return isFilter
    }
    
    
    func numberOfSections() -> Int {
        if isFilter{
            return Storage.shared.selectedCategories.count
        }else{
            return Storage.shared.coctails.count
        }
    }
    
    func numberOfRows(in section: Int) -> Int {
        if isFilter{
            let name = Storage.shared.selectedCategories[section]
            let count = Storage.shared.selectedCoctails[name]?.count
            return count ?? 0
        }else{
            guard let name = Storage.shared.categories?.drinks[section].strCategory else { return 0}
            let count = Storage.shared.coctails[name]?.count
            return count ?? 0
        }
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> CoctailTableViewCellViewModelType? {
        if isFilter{
            let name = Storage.shared.selectedCategories[indexPath.section]
            guard let coctail = Storage.shared.selectedCoctails[name] else { return nil }
            return CoctailTableViewCellViewModel(coctail: coctail[indexPath.row])
        }else{
            guard let name = Storage.shared.categories?.drinks[indexPath.section].strCategory else { return nil }
            guard let coctail = Storage.shared.coctails[name] else { return nil }
            return CoctailTableViewCellViewModel(coctail: coctail[indexPath.row])
        }
    }
    
    func titleForHeaderInSection(section: Int) -> String?{
        if isFilter{
            return Storage.shared.selectedCategories[section]
        }else{
            guard let name = Storage.shared.categories?.drinks[section].strCategory else { return nil }
            guard let coctail = Storage.shared.coctails[name], coctail.count > 0 else { return nil }
            return name
        }
    }
    
    
    func loadCategories(completion: @escaping () -> ()){
        Storage.shared.loadCatagoryCoctails { (coctailCategories) in
            completion()
        }
    }
    
    func loadCoctailByCategory(name: String, completion: @escaping () -> ()){
        Storage.shared.loadCoctailsFromCategory(name: name) { (coctail) in
            if self.isFilter == false{
                Storage.shared.coctails[name] = coctail
            }
            completion()
        }
    }
    
    func loadFirstCategory(completion: @escaping () -> ()){
        guard let categories = Storage.shared.categories else {
            completion()
            return
        }
        loadCoctailByCategory(name: categories.drinks[0].strCategory) {
            completion()
        }
    }
    
    func nextPage(completion: @escaping (Bool) -> ()){

        guard isLoad == false else { completion(false); return }
        
        print(currentPage, maxPage)
        guard isFilter == false, currentPage < maxPage else { completion(false); return }
        
        guard let categories = Storage.shared.categories?.drinks, currentPage != categories.count else { completion(false); return }
        
        isLoad = true
        let nameOfCategory = categories[currentPage].strCategory
        loadCoctailByCategory(name: nameOfCategory) {
            completion(true)
            self.isLoad = false
        }
        
    }

    
}
