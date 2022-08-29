//
//  StoreDatabase.swift
//  Project
//
//  Created by Azadeh Saleh on 2022-05-23.
//

import Foundation

class StoreDatabase{
    static let shared = StoreDatabase()
    private init() {}
    
    // list of Stores
    private var FairviewMallStores:[Store] = [Store(name: "Zara"),
    Store(name: "Apple")]
    
    private var NorthYorkStores:[Store] = [Store(name: "H&M"),
    Store(name: "Aldo")]
    
    func getAllFairviewMallStores() -> [Store] {
        return FairviewMallStores
    }
    
    func getAllNorthYorkStores() -> [Store] {
        return NorthYorkStores
    }
    
}
