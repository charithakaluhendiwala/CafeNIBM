
import UIKit

class ProfileViewController: UIViewController {
    
    let sessionM = SessionManager()
    
    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtEmail: UILabel!
    @IBOutlet weak var txtPhone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let user = sessionM.getUserInfo()
        txtName.text = user.userName
        txtEmail.text = user.userEmail
        txtPhone.text = user.userPhone
    }
    
    @IBAction func onSignOutPressed(_ sender: Any) {
        let sessionM = SessionManager()
        sessionM.clearLoginState()
    }
    
    
    
}
