
import UIKit
import Firebase

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.lightBlue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.white)
    }
    
    @IBAction func registerPressed(_ sender: UIButton) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            Auth.auth().createUser(withEmail: email, password: password) {authResult, error in
                if let e = error {
                    let errorAlert = UIAlertController(title: "Error", message: e.localizedDescription, preferredStyle: .alert)
                    errorAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(errorAlert, animated: true, completion: nil)
                } else {
                    let successAlert = UIAlertController(title: "Success", message: "You've successfully registered", preferredStyle: .alert)
                    successAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: {_ in
                        self.performSegue(withIdentifier: K.registerSegue, sender: self)
                    }))
                    self.present(successAlert, animated: true, completion: nil)
                }
            }
        }
    }
}
