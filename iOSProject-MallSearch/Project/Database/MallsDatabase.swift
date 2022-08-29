import Foundation
import UIKit

class MallsDatabase {
    static let shared = MallsDatabase()
  //  let StoreDB = StoreDatabase.shared
    private init() {
    }
    
    // list of Malls
    private var TorontoMalls:[Malls] = [

        Malls(name: "Fairview Mall",stores:[Stores(name: "Sport Chek",items: [Items(name: "Shoe", price: 46.0, im: "shoe"),Items(name: "Bag", price: 123.0, im: "bag"),Items(name: "Dress", price: 450.0, im: "dress"),Items(name: "Hat", price: 63.0, im: "hat")]),Stores(name: "Nike",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Jack & Jones",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "LCBO",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "Bayview Village Shopping Centre",stores:[Stores(name: "H&M",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Gap",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "East York Town Centre",stores:[Stores(name: "Roots",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Anthropologie",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "SoftMoc",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "Toronto Eaton Centre",stores:[Stores(name: "Adidas",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Aldo",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "H&M",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "Yorkdale Mall",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Aldo",items: [Items(name: "a", price: 46.0, im: "shoe")])])
    ]
    
    private var MontrealMalls:[Malls] = [
        Malls(name: "PLAZA ST HUBERT",stores:[Stores(name: "H&M",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Gap",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "LE VILLAGE GAI",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "Les Cours Mont-Royal",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Aldo",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "MARCHÉ BONSECOURS",stores:[Stores(name: "H&M",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Gap",items: [Items(name: "a", price: 46.0, im: "shoe")])])
    ]
  
    private var CalgaryMalls:[Malls] = [
        Malls(name: "Market Mall",stores:[Stores(name: "Sport Chek",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Nike",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Jack & Jones",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "LCBO",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "Chinook Centre",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "The CORE Shopping Centre",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "Eau Claire Market",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")])])
    ]
    
    private var OttawaMalls:[Malls] = [
        Malls(name: "Billings Bridge Plaza",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "Sparks Street Mall",stores:[Stores(name: "Adidas",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Aldo",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "H&M",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "College Square",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")])])
    ]
    
    private var VancouverMalls:[Malls] = [
        Malls(name: "Capilano Mall",stores:[Stores(name: "Zara",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Apple",items: [Items(name: "a", price: 46.0, im: "shoe")])]),
        Malls(name: "Coquitlam Centre",stores:[Stores(name: "Adidas",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "Aldo",items: [Items(name: "a", price: 46.0, im: "shoe")]),Stores(name: "H&M",items: [Items(name: "a", price: 46.0, im: "shoe")])])
    ]
    
 
    func getAllTorontoMalls() -> [Malls] {
        return TorontoMalls
    }
    func getAllMontrealMalls() -> [Malls] {
        return MontrealMalls
    }
    func getAllCalgaryMalls() -> [Malls] {
        return CalgaryMalls
    }
    func getAllOttawaMalls() -> [Malls] {
        return OttawaMalls
    }
    func getAllVancouverMalls() -> [Malls] {
        return VancouverMalls
    }
    
    
    
}

