import Foundation
import UIKit

class register: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    
    // MARK: Outlets
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    @IBOutlet weak var uploadSign: UIButton!
    @IBOutlet weak var msgLable: UILabel!
    
    private var userList : [Users] = [Users]()
    
    private let dbHelper = coreDBHelper.getInstance()
   
    
    @IBAction func uploadImage(_ sender: Any) {
        print("upload your photo")
        // create an image picker object
        // this object lets to choose the "source" of our photos (camera, photo gallery, etc)
        let imagePicker = UIImagePickerController()
        // check if a camera is availble, if yes, then show the camera
        if (UIImagePickerController.isSourceTypeAvailable(.camera) == true) {
            print("Camera is available")
            // open the camera and get a photo
            imagePicker.sourceType = .camera
            imagePicker.delegate = self
            
            present(imagePicker, animated: true, completion:nil)
        }
        else {
            print("Camera not available")
            imagePicker.sourceType = .photoLibrary
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            present(imagePicker, animated: true, completion:nil)
        }
    }//uploadImage
    
    //Detect when did the user finish choosing a photo from the photo picker popup
       func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
           // This function will execute when the user finishes choosing a photo (or) taking a photo with the camera
           print("User finished selecting a photo.")
           // close the picker popup
           picker.dismiss(animated: true, completion: nil)
           print("Closed the popup.")
           // get the photo the person selected
           guard let imageFromPicker = info[.originalImage] as? UIImage else {
               print("Error getting the photo")
               return
           }
           // display it in an UIImageView outlet
           image.image = imageFromPicker
           
           picker.dismiss(animated: true, completion: nil)
           
       }

    
    // MARK: Actions
    @IBAction func btnRegisterPushed(_ sender: Any) {
        print(#function,"Register Button is pressed")
        // get the photo from the displayed imageview in the ui
        guard let imageToSave = image.image else {
            print("Sorry, no photo available")
            return
        }
        // save it to the device's gallery
        UIImageWriteToSavedPhotosAlbum(imageToSave, self, #selector(didFinishSaving), nil)
        
        // save it into the core
        guard let userName = txtName.text,
              let userAge = self.txtAge.text,
              let userEmail = txtEmail.text ,
              var user_password = txtPassword.text,
              let verifyPass = txtRePassword.text
        else {
            print("Data are not assigned")
            return
        }
        if (userName.isEmpty || userAge.isEmpty || userEmail.isEmpty || user_password.isEmpty || verifyPass.isEmpty){
            print("You must enter in all fields!")
            self.msgLable.textColor = UIColor.red
            self.msgLable.text = "You must enter in all fields!"
        } else {
            if (comparePass(InitialPass: user_password, verifyPass: verifyPass)){
                user_password = verifyPass
                var user_image = (image.image?.pngData())!
                // add user to core data
                self.dbHelper.addUser(user_name: userName, user_age: Int16(userAge)!, user_email: userEmail, user_password: user_password,user_image: user_image)
                print("You are registered!")
                self.msgLable.textColor = UIColor.green
                self.msgLable.text = "Registered"
                
            }
        }
    }
    
    // for saving photo from camera on device
    @objc func didFinishSaving(_ image:UIImage, withError error:Error?, contextInfo:UnsafeRawPointer) {
        guard error == nil else {
            print("Error saving photo")
            return
        }
        print("Photo saved!")
    }
    
    // comparing passwords
    private func comparePass(InitialPass:String,verifyPass:String) -> Bool{
        if InitialPass == verifyPass {
            return true
        } else {
            print("Passwords are not matched! Please make sure passwors are the same")
            self.msgLable.textColor = UIColor.red
            self.msgLable.text = "Passwords are not matched!"
            txtPassword.text = ""
            txtRePassword.text = ""
        }
        return false
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        uploadSign.imageView?.layer.transform = CATransform3DMakeScale(1, 1, 1)

        image.layer.borderWidth = 1
        image.layer.masksToBounds = false
        image.layer.borderColor = UIColor.black.cgColor
        image.layer.cornerRadius = image.frame.height/2
        image.clipsToBounds = true
        
        self.msgLable.text = ""
      
    }
}
