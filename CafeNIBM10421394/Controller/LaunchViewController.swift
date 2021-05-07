import UIKit

class LaunchViewController: UIViewController {
    
    let sessionM = SessionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()


    }

    override func viewDidAppear(_ animated: Bool) {
        if sessionM.getLogginState(){
            self.performSegue(withIdentifier: "HomeLaunch", sender: nil)
        }else{
            self.performSegue(withIdentifier: "LoginLaunch", sender: nil)
        }
    }
}
    

