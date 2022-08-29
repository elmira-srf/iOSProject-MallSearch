import Foundation
import UIKit

class Items{
    var name: String
    var price: Double
    var image: String?
    var flag: Bool = false
//    var id: UUID()
    
    
    init(name: String, price: Double){
        self.name = name
        self.price = price
    }
    init(name:String, price:Double, im:String?){
        self.name = name
        self.price = price
        self.image = im
    }
}
