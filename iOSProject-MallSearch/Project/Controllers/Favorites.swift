

import Foundation
import UIKit

class favorites:UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    private let FavoritedbHelper = favoriteHelper.getInstance()
    private var favoritesList : [Favorites] = [Favorites]()
    private let dbHelper = coreDBHelper.getInstance()
    private var userList : Users?
    var thisUserFavorites:[Favorites]=[]

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        fetchCurrentUsers()
        
//        for f in favoritesList{
//            if f.userID == userList?.id {
//                thisUserFavorites.append(f)
//            }
//        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.reloadData()
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchAllItems()
        fetchCurrentUsers()

        thisUserFavorites = []
        for f in favoritesList{
            if f.userID == userList?.id {
                thisUserFavorites.append(f)
            }
        }
        self.tableView.rowHeight = 70
        tableView.reloadData()
    }
    // MARK: Tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisUserFavorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell to display
        let cell = tableView.dequeueReusableCell(withIdentifier: "favoriteCell", for: indexPath) as! favoriteTableViewCell
        // Get the data for this row
        let rowData = thisUserFavorites[indexPath.row]
        cell.lblName.text = rowData.name
        cell.lblPrice.text = "\(rowData.price)"
        cell.imFavoritIrem.image = UIImage(named: rowData.image!)
        cell.lblMall.text = rowData.mall
        cell.lblStore.text = rowData.store
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = thisUserFavorites[indexPath.row]
            FavoritedbHelper.deleteItem(itemID: item.id!)
            thisUserFavorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
    
    // MARK: Helper functions
    func fetchAllItems(){
        let data = self.FavoritedbHelper.getAllItems()
                if (data != nil){
                    self.favoritesList = data!
                  
                } else {
                    print(#function, "No Data has received from database")
                }
    }
    private func fetchCurrentUsers(){
        let data = self.dbHelper.getCurrentUser()
        if (data != nil){
            self.userList = data
          
        } else {
            print(#function, "No Data has received from database")
        }
    }
}
