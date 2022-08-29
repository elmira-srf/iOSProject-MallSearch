import Foundation
import CoreData
import UIKit

class itemHelper{
    private static var shared : itemHelper?
    private let mocItem:NSManagedObjectContext
    private let Entity_Name = "Item"
    
    static func getInstance() -> itemHelper{
        if shared == nil {
            shared = itemHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
        return shared!
    }
    
    private init(context:NSManagedObjectContext){
        self.mocItem = context
    }
    
    
   
    
    func makeItemFavourite(updatedOrder: Item){
        let searchResult = self.searchItem(itemID: updatedOrder.id! as UUID)
        if (searchResult != nil){
            do{
                let itemToFavourite = searchResult!
                itemToFavourite.isFavorite = true
                try self.mocItem.save()
                print(#function, "Item is favourite")
            }catch let error as NSError{
                print(#function, "Could not make favourite the item \(error)")
            }
        }else{
            print(#function, "No matching data found")
        }
    }
    
    
    func addToItem(image:String,name:String,price:Double, store: String, mall: String){
        do {
            let itemToBeFavourit = NSEntityDescription.insertNewObject(forEntityName: Entity_Name, into: self.mocItem) as! Item
            itemToBeFavourit.id = UUID()
            itemToBeFavourit.date = Date()
            itemToBeFavourit.image = image
            itemToBeFavourit.name = name
            itemToBeFavourit.store = store
            itemToBeFavourit.price = price
            itemToBeFavourit.mall = mall
            if self.mocItem.hasChanges{
                try self.mocItem.save()
                print(#function, "Information is saved successfully in CoreData")
            }
        } catch let error as NSError{
            print(#function, "Could not save the Information \(error)")

        }
    }
    
    func getAllItems() -> [Item]?{
        let fetchRequest = NSFetchRequest<Item>(entityName: Entity_Name)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: false)]
        
        do{
            let result = try self.mocItem.fetch(fetchRequest)
            print(#function, "****Fetched Data****")
            return result as [Item]
        }catch let error as NSError{
            print(#function, "Could not fetch the data \(error)")
        }
        return nil
    }
    
    
    func searchItem(itemID : UUID) -> Item?{

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity_Name)
        let predicateID = NSPredicate(format: "id == %@", itemID as CVarArg)
        fetchRequest.predicate = predicateID

        do{

            let result = try self.mocItem.fetch(fetchRequest)

            if result.count > 0{
                print(#function, "Matching object found")
                return result.first as? Item
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

                self.mocItem.delete(searchResult!)
                try self.mocItem.save()

                print(#function, "Item deleted successfully")

            }catch let error as NSError{
                print(#function, "Could not delete the item \(error)")
            }
        }else{
            print(#function, "No matching record found")
        }
    }
    
}
