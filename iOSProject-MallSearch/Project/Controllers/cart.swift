import Foundation
import UIKit

class cart:UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    // MARK: Outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var lblTotal: UILabel!
    
    private let CartdbHelper = cartHelper.getInstance()
    private var cartList : [Cart] = [Cart]()
    private let dbHelper = coreDBHelper.getInstance()
    private var userList : Users?
    var total = 0.0
    var thisUserCart:[Cart]=[]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
        fetchCurrentUsers()
        
        for c in cartList{
            if c.userID == userList?.id {
                thisUserCart.append(c)
            }
        }
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = 70
        
        tableView.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        fetchAllItems()
        fetchCurrentUsers()

        thisUserCart = []
        for c in cartList{
            if c.userID == userList?.id {
                thisUserCart.append(c)
            }
        }
        total = 0.0
        for c in thisUserCart{
            total = total + c.price
        }
        lblTotal.text = "\(total)"
        self.tableView.rowHeight = 70
        tableView.reloadData()
    }
    
    // MARK: Tableview functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thisUserCart.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Get a cell to display
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartCell", for: indexPath) as! cartTableViewCell
        // Get the data for this row
        
        
        let rowData = thisUserCart[indexPath.row]
        cell.lblName.text = rowData.name
        cell.lblPrice.text = "\(rowData.price)"
        cell.imCartItem.image = UIImage(named: rowData.image!)
        return cell
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let item = thisUserCart[indexPath.row]
            CartdbHelper.deleteItem(itemID: item.id!)
            thisUserCart.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            total = 0.0
            for item in thisUserCart{
                total = total + item.price
            }
            lblTotal.text = "\(total)"
        }
    }
    
    // MARK: Helper functions
    func fetchAllItems(){
        let data = self.CartdbHelper.getAllItems()
                if (data != nil){
                    self.cartList = data!
                  
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
