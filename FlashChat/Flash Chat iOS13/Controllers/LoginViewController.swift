
import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailTextfield: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emailTextfield.delegate = self
        passwordTextfield.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.blue)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.navigationBar.barTintColor = UIColor(named: K.BrandColors.white)
    }
    
    @IBAction func loginPressed(_ sender: UIButton) {
        if emailTextfield.text == "" || passwordTextfield.text == "" {
            emailTextfield.placeholder = "Type email"
            passwordTextfield.placeholder = "Type password"
        } else {
            if let email = emailTextfield.text, let password = passwordTextfield.text {
                Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                    if let e = error {
                        print(e.localizedDescription)
                    } else {
                        self.performSegue(withIdentifier: K.loginSegue, sender: self)
                    }
                }
            }
        }
    }
}
extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        if emailTextfield.text != "" || passwordTextfield.text != "" {
            return true
        } else {
            emailTextfield.placeholder = "Type email"
            passwordTextfield.placeholder = "Type password"
            return false
        }
    }
}
