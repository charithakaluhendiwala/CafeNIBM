import UIKit
import Loaf
import Firebase

class SigninViewController: UIViewController {
    
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        ref = Database.database().reference()

    }
    
    
    @IBAction func onSigninPressed(_ sender: UIButton) {
        
        if !InputValidator.isValidEmail(email: txtEmail.text ?? ""){
            let alert = UIAlertController(title: "Error", message: "Please Check Your Email and Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        if !InputValidator.isValidPassword(pass: txtPassword.text ?? "", minLength: 6, maxLength: 50){
            let alert = UIAlertController(title: "Error", message: "Please Check Your Email and Password", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return
        }
        
            authnticateUser(email: txtEmail.text!, password: txtPassword.text!)
    }
    
    //user Authentication part
    func authnticateUser(email: String, password: String) {
        Auth.auth().signIn(withEmail:email, password: password){
            authReslt,error in
            
            if let err = error{
                print(err.localizedDescription)
                Loaf("Password or Username is invalid", state: .error , sender: self).show()
            }
            
            if let email = authReslt?.user.email{
                self.getUserInfo(email: email)
            }else{
                Loaf("User not found", state: .error , sender: self).show()
            }
                   
        }
    }
    
    func getUserInfo(email: String){
        ref.child("users")
            .child(email
                .replacingOccurrences(of: "@", with: "_")
                .replacingOccurrences(of: ".", with: "_")).observe(.value, with: {
            (snapshot) in
            if snapshot.hasChildren(){
                if let info = snapshot.value {
                    if let userData = info as? [String: String] {
                                    let user = User(
                                        userName: userData["userName"]!,
                                        userEmail: userData["userEmail"]!,
                                        userPassword: userData["userPassword"]!,
                                        userPhone: userData["userPhone"]!
                                        )
                                    let sessionM = SessionManager()
                                    sessionM.saveUserLogin(user: user)
                                    //move to home screen
                                    self.performSegue(withIdentifier: "LoginToHome", sender: nil)
                                }
                }
                            }else{
                                Loaf("User not found", state: .error , sender: self).show()
 
                            }
        })
    }
}
