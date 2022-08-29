

import Foundation
import UIKit

class profile:UIViewController {
    
    @IBOutlet weak var CurrentUserEmailLabel: UILabel!
    @IBOutlet weak var currentUserNameLabel: UILabel!
    @IBOutlet weak var user_image: UIImageView!
    
    private let dbHelper = coreDBHelper.getInstance()
    private var userList : Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        user_image.layer.borderWidth = 1
        user_image.layer.masksToBounds = false
        user_image.layer.borderColor = UIColor.black.cgColor
        user_image.layer.cornerRadius = user_image.frame.height/2
        user_image.clipsToBounds = true
        
        fetchCurrentUsers()
        print(("Hello \(userList?.name)"))
        self.currentUserNameLabel.text = userList?.name
        self.CurrentUserEmailLabel.text = userList?.email
        self.user_image.image = UIImage(data: (userList?.picture!)! as Data)

        
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
