
import UIKit
import Firebase

class ForgotPasswordViewController: UIViewController {
    
    @IBOutlet weak var emailTextField: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.blue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.white)
    }
    
    @IBAction func sendPressed(_ sender: UIButton) {
        if let email = emailTextField.text {
            Auth.auth().sendPasswordReset(withEmail: email) { (error) in
                if let e = error {
                    print(e.localizedDescription)
                } else {
                    print("Link was sent to \(email)")
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
        
    }
    
}
