import Foundation
import CoreData
import UIKit

class favoriteHelper {
    private static var shared : favoriteHelper?
    private let mocFavorite:NSManagedObjectContext
    private let Entity_Name = "Favorites"
    
    static func getInstance() -> favoriteHelper{
        if shared == nil {
            shared = favoriteHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
        return shared!
    }

    private init(context:NSManagedObjectContext){
        self.mocFavorite = context
    }
    
    func addToFavorites(image:String,name:String,price:Double,storeName:String,mallName:String,currentUser:UUID){
        do {
            let itemToBeAdded = NSEntityDescription.insertNewObject(forEntityName: Entity_Name, into: self.mocFavorite) as! Favorites
            itemToBeAdded.image = image
            itemToBeAdded.name = name
            itemToBeAdded.price = price
            itemToBeAdded.store = storeName
            itemToBeAdded.mall = mallName
            itemToBeAdded.id = UUID()
            itemToBeAdded.userID = currentUser
            itemToBeAdded.date = Date()

            if self.mocFavorite.hasChanges{
                try self.mocFavorite.save()
                print(#function, "Information is saved successfully in CoreData")
            }
        } catch let error as NSError{
            print(#function, "Could not save the Information \(error)")

        }
    }

    func getAllItems() -> [Favorites]?{
        let fetchRequest = NSFetchRequest<Favorites>(entityName: Entity_Name)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "date", ascending: false)]
        
        do{
            let result = try self.mocFavorite.fetch(fetchRequest)
            print(#function, "****Fetched Data****")
            return result as [Favorites]
        }catch let error as NSError{
            print(#function, "Could not fetch the data \(error)")
        }
        return nil
    }
    
    
    func searchItem(itemID : UUID) -> Favorites?{

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity_Name)
        let predicateID = NSPredicate(format: "id == %@", itemID as CVarArg)
        fetchRequest.predicate = predicateID

        do{

            let result = try self.mocFavorite.fetch(fetchRequest)

            if result.count > 0{
                print(#function, "Matching object found")
                return result.first as? Favorites
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

                self.mocFavorite.delete(searchResult!)
                try self.mocFavorite.save()

                print(#function, "Item deleted successfully")

            }catch let error as NSError{
                print(#function, "Could not delete the item \(error)")
            }
        }else{
            print(#function, "No matching record found")
        }
    }
}
