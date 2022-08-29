import Foundation
import UIKit

class theStore:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var lblStoreName: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var currentStore: Stores?
    var currentMall: Malls?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.lblStoreName.text = currentStore?.name
        
        collectionView.delegate = self
        collectionView.dataSource = self
        print("The store screen is loaded")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (currentStore?.items.count)!
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item = collectionView.dequeueReusableCell(withReuseIdentifier: "myItem", for: indexPath) as! CollectionViewCell
        item.image.image = UIImage(named: (currentStore?.items[indexPath.row].image!)!)
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let nextScreen = storyboard?.instantiateViewController(identifier: "itemInStore") as? itemInStore else {
            print("Cannot find next screen")
            return
        }
        
        nextScreen.currentItem = currentStore?.items[indexPath.row]
        nextScreen.currentMall = currentMall
        nextScreen.currentStore = currentStore
        
        self.navigationController?.pushViewController(nextScreen, animated: true)
        
        print("Go to next screen from collection")
        return
    }
}
