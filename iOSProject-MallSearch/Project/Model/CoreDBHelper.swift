import Foundation
import CoreData
import UIKit

class coreDBHelper{
    // singletone pattern
    private static var shared : coreDBHelper?
    private let moc:NSManagedObjectContext
    private let Entity_Name = "Users"
    var imageSaved:UIImage?
    private var current_user:Users?
    
    static func getInstance() -> coreDBHelper{
        if shared == nil {
            shared = coreDBHelper(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        }
        return shared!
    }
    
    private init(context:NSManagedObjectContext){
        self.moc = context
    }
    
    func addUser(user_name:String,user_age:Int16,user_email:String,user_password:String,user_image:Data){
        do {
            let userToBeRegistered = NSEntityDescription.insertNewObject(forEntityName: Entity_Name, into: self.moc) as! Users
            userToBeRegistered.id = UUID()
            userToBeRegistered.name = user_name
            userToBeRegistered.age = user_age
            userToBeRegistered.email = user_email
            userToBeRegistered.password = user_password
            userToBeRegistered.picture = user_image
            
            if self.moc.hasChanges{
                try self.moc.save()
                print(#function, "User's Information is saved successfully in CoreData")
            }
        } catch let error as NSError{
            print(#function, "Could not save the User's Information \(error)")
        }
    }
    
    func getAllUsers() -> [Users]?{
        let fetchRequest = NSFetchRequest<Users>(entityName: Entity_Name)
        fetchRequest.sortDescriptors = [NSSortDescriptor.init(key: "id", ascending: false)]
        do{
            let result = try self.moc.fetch(fetchRequest)
            print(#function, "****Fetched Data****")
            return result as [Users]
        }catch let error as NSError{
            print(#function, "Could not fetch the data \(error)")
        }
        return nil
    }
    
    func setCurrentUser(currentUser:Users){
        let searchResult = self.searchUser(userID: currentUser.id! as UUID)
        if (searchResult != nil){
            do {
                let userToUpdate = searchResult!
                userToUpdate.isCurrent = true
                try self.moc.save()
                print(#function, "\(userToUpdate.name) is the current user!")
            } catch let error as NSError{
                print(#function, "Could not update the order \(error)")
            }
        }
    }
    
     func getCurrentUser() -> Users?{
        let fetchRequest = NSFetchRequest<Users>(entityName: Entity_Name)
        do{
            let result = try self.moc.fetch(fetchRequest)
            for r in result{
                if r.isCurrent {
                    return r
                }
            }
        }catch let error as NSError{
            print(#function, "Unable to search for the current user \(error)")
        }
        
        return current_user
    }
    
    func removeCurrentUser(){
        let fetchRequest = NSFetchRequest<Users>(entityName: Entity_Name)
        do{
            let result = try self.moc.fetch(fetchRequest)
            for r in result{
                r.isCurrent = false
            }
            try self.moc.save()
        }catch let error as NSError{
            print(#function, "Unable to remove  the current user \(error)")
        }
    }
    
    func searchUser(userID : UUID) -> Users?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: Entity_Name)
        let predicateID = NSPredicate(format: "id == %@", userID as CVarArg)
        fetchRequest.predicate = predicateID
        
        do{
            let result = try self.moc.fetch(fetchRequest)
            if result.count > 0{
                print(#function, "Matching object found")
                return result.first as? Users
            }
        }catch let error as NSError{
            print(#function, "Unable to search for order \(error)")
        }
        return nil
    }
   
    
}
