import UIKit

class ViewController: UIViewController {

    // MARK: Outlets
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var `switch`: UISwitch!
    @IBOutlet weak var msgLabel: UILabel!
    
    var defaults = UserDefaults.standard
    private let dbHelper = coreDBHelper.getInstance()
    private var userList : [Users] = [Users]()
    private var currentUser : Users?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchAllUsers()
        
        self.switch.isOn = false
        
        // retrieve data for Automatically Login
        if (defaults.bool(forKey: "loggedIn") == true) {
            if dbHelper.getCurrentUser() != nil{
                // Get the Current User's information
                currentUser = dbHelper.getCurrentUser()!
            }
            
            guard let goToHomeScreen = storyboard?.instantiateViewController(identifier: "HomeScreen") as? UITabBarController else {
                print("Cannot find next screen")
                return
            }
            self.navigationController?.pushViewController(goToHomeScreen, animated: false)
            return
        }
        else {
            // in order to LogOut
            defaults.set(false, forKey: "loggedIn")
            //delete current users key
           self.dbHelper.removeCurrentUser()
        }
        
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    
    // Get All users information from Core
    private func fetchAllUsers(){
        let data = self.dbHelper.getAllUsers()
        if (data != nil){
            self.userList = data!
          
        } else {
            print(#function, "No Data has received from database")
        }
    }

    // MARK: Actions
    @IBAction func btnSigninPushed(_ sender: Any) {
        print("Signin Button Pushed")
        guard let userEmail = txtEmail.text, let userPassword = txtPassword.text else {
            print("Data are not assigned")
            return
        }
        if (userEmail.isEmpty){
            self.msgLabel.textColor = UIColor.red
            self.msgLabel.text = "You must enter email!"
        } else if (userPassword.isEmpty){
            self.msgLabel.textColor = UIColor.red
            self.msgLabel.text = "You must enter password!"
        } else {
            var successfull = false
            for user in userList{
                if (user.email == userEmail
                    && user.password == userPassword){
                    successfull = true
                    dbHelper.removeCurrentUser()
                    dbHelper.setCurrentUser(currentUser: user)
                    if `switch`.isOn {
                        // save data for Automatically Login
                        defaults.set(true, forKey: "loggedIn")
                    }// if for Switch
                    
                    // - try to get a reference to the Home Screen
                    guard let goToHomeScreen = storyboard?.instantiateViewController(identifier: "HomeScreen") as? UITabBarController else {
                        print("Cannot find Home Screen")
                        return
                    }
                    self.navigationController?.pushViewController(goToHomeScreen, animated: true)
                }// if for correct password & email
            }//for
            if !successfull{
                self.msgLabel.textColor = UIColor.red
                self.msgLabel.text = "Incorrect Email or Password!"
            }
            txtEmail.text = ""
            txtPassword.text = ""
        }
       
    }
    
    @IBAction func btnRegisterPushed(_ sender: Any) {
        print("Register Button Pushed")
        guard let regScreen = storyboard?.instantiateViewController(identifier: "registerScreen") as? register else {
            print("Cannot find next screen")
            return
        }
        // - navigate to the next screen
        self.navigationController?.pushViewController(regScreen, animated: true)

    }
  
}

