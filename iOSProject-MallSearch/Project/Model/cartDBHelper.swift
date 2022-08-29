

import Foundation
import CoreData
import UIKit

class cartHelper{
    private static var shared : cartHelper?
    private let mocCart:NSManagedObjectContext
    private let Entity_Name = "Cart"
  
    
    static func getInstance() -> cartHelper{
        if shared == nil {
            shared = cartHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
        return shared!
    }
    
    private init(context:NSManagedObjectContext){
        self.mocCart = context
    }
    
    func addToCart(image:String,name:String,price:Double,currentUser:UUID){
        do {
            let itemToBeAdded = NSEntityDescription.insertNewObject(forEntityName: Entity_Name, into: self.mocCart) as! Cart
            itemToBeAdded.id = UUID()
            itemToBeAdded.userID = currentUser
            itemToBeAdded.image = image
            itemToBeAdded.name = name
            itemToBeAdded.price = price
            itemToBeAdded.date = Date()

            if self.mocCart.hasChanges{
                try self.mocCart.save()
                print(#function, "Information is saved successfully in CoreData")
            }
        } catch let error as NSError{
            print(#function, "Could not save the Information \(error)")

        }
    }
    
    func getAllItems() -> [Cart]?{
        let fetchRequest = NSFetchRequest<Cart>(entityName: Entity_Name)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        
        do{
            let result = try self.mocCart.fetch(fetchRequest)
            print(#function, "****Fetched Data****")
            return result as [Cart]
        }catch let error as NSError{
            print(#function, "Could not fetch the data \(error)")
        }
        return nil
    }
    
    
    func searchItem(itemID : UUID) -> Cart?{

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity_Name)
        let predicateID = NSPredicate(format: "id == %@", itemID as CVarArg)
        fetchRequest.predicate = predicateID

        do{

            let result = try self.mocCart.fetch(fetchRequest)

            if result.count > 0{
                print(#function, "Matching object found")
                return result.first as? Cart
            }

        }catch let error as NSError{
            print(#function, "Unable to search for item \(error)")
        }

        return nil
    }
    func deleteItem(itemID : UUID){
        //search for task using ID to obtain the object
        let searchResult = self.searchItem(itemID: itemID)

        //perform delete operation using object, if found
        if (searchResult != nil){
            //matching task found
            do{

                self.mocCart.delete(searchResult!)
                try self.mocCart.save()

                print(#function, "Item deleted successfully")

            }catch let error as NSError{
                print(#function, "Could not delete the item \(error)")
            }
        }else{
            print(#function, "No matching record found")
        }
    }
    
}
