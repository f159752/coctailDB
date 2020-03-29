//
//  Storage.swift
//  coctailDB
//
//  Created by Artem Shpilka on 3/27/20.
//  Copyright © 2020 Artem Shpilka. All rights reserved.
//

import Foundation
import Moya

class Storage{
    static let shared = Storage()
    private init(){}
    private let provider = MoyaProvider<Network>()
    
    
    var categories: CoctailCategories?
    var coctails: [String: [Coctail]] = [:]
    
    var selectedCategories: [String] = []
    var selectedCoctails: [String: [Coctail]] = [:]
    
    func loadCatagoryCoctails(completion: @escaping (CoctailCategories?) -> ()){
        provider.request(.getCategory) { (result) in
            switch result{
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let statusCode = moyaResponse.statusCode
                
                guard 200...299 ~= statusCode else { return }
                
                if let categories = try? JSONDecoder().decode(CoctailCategories.self, from: data){
                    self.categories = categories
                    completion(categories)
                }else{
                    self.categories = CoctailCategories(drinks: [])
                    completion(nil)
                }
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func loadCoctailsFromCategory(name: String, completion: @escaping ([Coctail]?) -> ()){
        provider.request(.getCoctails(name: name)) { (result) in
            switch result{
            case let .success(moyaResponse):
                let data = moyaResponse.data
                let statusCode = moyaResponse.statusCode
                
                guard 200...299 ~= statusCode else { return }
                
                if let coctails = try? JSONDecoder().decode(CoctailsResponse.self, from: data){
                    completion(coctails.drinks)
                }else{
                    completion(nil)
                }
                
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    
    func filter(num: [IndexPath], completion: @escaping ([String: [Coctail]]) -> ()){
        guard let categories = categories else { completion([:]); return }

        selectedCategories = []
        selectedCoctails = [:]
        
        guard num.count > 0 else {
            completion(selectedCoctails)
            return
        }
        
        for i in num{
            let nameCategory = categories.drinks[i.row].strCategory
            selectedCategories.append(nameCategory)
            
            if let coctailsByCategory = coctails[nameCategory]{
                selectedCoctails[nameCategory] = coctailsByCategory
                completion(selectedCoctails)
                if num[num.count - 1].row == i.row{
                    completion(selectedCoctails)
                }
            }else{
                loadCoctailsFromCategory(name: nameCategory) { (coctails) in
                    self.selectedCoctails[nameCategory] = coctails
                    if num[num.count - 1].row == i.row{
                        completion(self.selectedCoctails)
                    }
                }
            }
        }
    }
    
    func getIndexOfCategory(name: String) -> Int?{
        guard let categories = categories else { return nil }
        for (index, item) in categories.drinks.enumerated(){
            if name == item.strCategory{
                return index
            }
        }
        return nil
    }
    
    
    
}
