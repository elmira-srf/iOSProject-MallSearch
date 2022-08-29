import Foundation
class Malls{
    var name:String
    var latitude:Double?
    var longitude : Double?
    var stores :[Stores]?
    
    init(name:String){
        self.name = name
    }
    
    init(name:String,stores:[Stores]){
        self.name = name
        self.stores = stores
    }
}
