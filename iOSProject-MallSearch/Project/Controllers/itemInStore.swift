import Foundation
import UIKit

class itemInStore: UIViewController{
    
    
    // MARK: Outlets
    
    @IBOutlet weak var image: UIImageView!
    
    @IBOutlet weak var lblItemName: UILabel!
    @IBOutlet weak var lblItemPrice: UILabel!
    
    @IBOutlet weak var btnFavorite: UIButton!
    
    private let CartdbHelper = cartHelper.getInstance()
    private let FavoritedbHelper = favoriteHelper.getInstance()
    private let ItemDBHelper = itemHelper.getInstance()
    private let dbHelper = coreDBHelper.getInstance()
    private var userList : Users?

    var currentItem: Items?
    var currentStore: Stores?
    var currentMall: Malls?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCurrentUsers()
        
        lblItemName.text = currentItem?.name
        lblItemPrice.text = "\((currentItem?.price)!)"
        image.image = (UIImage(named: (currentItem?.image)!)!)
        if((currentItem?.flag)!){
            self.btnFavorite.setImage( UIImage( systemName:"heart.fill"), for: .normal)
            
        }else {
            self.btnFavorite.setImage( UIImage( systemName:"heart"), for: .normal)
        }
    }
    
    // MARK: Actions
    @IBAction func btnFavoritPushed(_ sender: Any) {
        currentItem?.flag.toggle()
        // new
        if((currentItem?.flag)!){
            self.btnFavorite.setImage( UIImage( systemName:"heart.fill"), for: .normal)
            //add the item to favorit list
            guard let image = currentItem?.image,
                  let name = currentItem?.name,
                  let price = currentItem?.price,
                  let store = currentStore?.name,
                  let mall = currentMall?.name
            else {
                print("Data are not assigned")
                return
            }
            self.FavoritedbHelper.addToFavorites(image: image, name: name, price: price, storeName: store, mallName: mall, currentUser: (userList?.id)!)
            print("Item is added into favourite")
        } else {
            self.btnFavorite.setImage( UIImage( systemName:"heart"), for: .normal)
//            FavoritedbHelper.deleteItem(itemID: currentItem.id)
        }
    }
    
    @IBAction func btnAddToCartPushed(_ sender: Any) {
        print(#function)
        // add the item to cart list
        guard let image = currentItem?.image,
              let name = currentItem?.name,
              let price = currentItem?.price
        else {
            print("Data are not assigned")
            return
        }
        self.CartdbHelper.addToCart(image: (currentItem?.image)!, name: name, price: price , currentUser: (userList?.id)!)
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
