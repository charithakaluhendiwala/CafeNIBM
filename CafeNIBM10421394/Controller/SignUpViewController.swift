import UIKit
import Firebase
import Loaf

class SignUpViewController: UIViewController {
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()
    }
    

    //new user registration
    func registerUser(user:User){
        Auth.auth().createUser(withEmail: user.userEmail, password: user.userPassword) {
            authResult, error in
            
            if let err = error{
                print(err.localizedDescription)
                let alert = UIAlertController(title: "Error", message: "User allready have an Account", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                return
            }
            

            
            self.saveUserData(user: user)
        }
        
    }
    
    //back to the Login Screen
    @IBAction func onLoginPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)

    }
    
    @IBAction func onSignUpPressed(_ sender: Any) {
        
        if !InputValidator.isValidName(name: txtName.text ?? ""){
            Loaf("Please use a standarded name pattern", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidEmail(email: txtEmail.text ?? ""){
            Loaf("Please use a standarded Email pattern", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidMobileNo(txtPhone.text ?? ""){
            Loaf("Please use a standarded Phone pattern", state: .error, sender: self).show()
            return
        }
        
        if !InputValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 50){
            Loaf("Please use a standarded Password pattern", state: .error, sender: self).show()
            return
        }
        
        let user = User(userName: txtName.text ?? "", userEmail: txtEmail.text ?? "", userPassword: txtPassword.text ?? "", userPhone: txtPhone.text ?? "")
        
        registerUser(user:user)
    }
    
    func saveUserData(user:User){
        
        let userData = [
            "userName" : user.userName,
            "userEmail" : user.userEmail,
            "userPhone" : user.userPhone,
            "userPassword" : user.userPassword,
        ]
        
        self.ref.child("users").child(user.userEmail.replacingOccurrences(of: "@", with: "_").replacingOccurrences(of: ".", with: "_")).setValue(userData){
            (error, ref) in
            
            if let err = error{
                print(err.localizedDescription)
                Loaf("Signup Failed", state: .error, sender: self).show()
                return
            }
            Loaf("Created new user", state: .success, sender: self).show(){
                type in
                self.dismiss(animated: true, completion: nil)
            }
            
                
        }
    }
    
}
