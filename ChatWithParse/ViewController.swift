//
//  ViewController.swift
//  ChatWithParse
//

import UIKit
import Parse

class ViewController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    
    var user: PFUser?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginPressed(_ sender: AnyObject) {
        login(username: loginTextField.text!, password: passwordTextField.text!)
    }

    @IBAction func signupPressed(_ sender: AnyObject) {
        signup(username: loginTextField.text!, password: passwordTextField.text!, email: emailTextField.text!)
    }
    
    func signup(username: String, password: String, email: String) {
        let user = PFUser()
        user.username = username
        user.password = password
        user.email = email
        // other fields can be set just like with PFObject
        
        user.signUpInBackground(block: {
            (succeeded: Bool, error: Error?) -> Void in
            if let error = error {
                let errorString = error.localizedDescription;
                print("Error signing up \(errorString)");
                self.showAlert(errorTitle: "Sign up error", errorString: errorString)
            } else {
                // Hooray! Let them use the app now.
            }
        })
    }
    
    func login(username: String, password: String) {

        
        PFUser.logInWithUsername(inBackground: username, password: password) {
            (user: PFUser?, error: Error?) in
            // code
            if let error = error {
                let errorString = error.localizedDescription;
                self.showAlert(errorTitle: "Sign in error", errorString: errorString)
            } else {
                if let user = user {
                    self.user = user
                    print("user logged in \(user)")
                }
            }
        }
        
    }
    
    func showAlert(errorTitle: String, errorString: String) {
        let alertController = UIAlertController(title: errorTitle, message: errorString, preferredStyle: .alert)
        
        // create an OK action
        let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
            // handle response here.
        }
        // add the OK action to the alert controller
        alertController.addAction(OKAction)
        present(alertController, animated: true) {
            // optional code for what happens after the alert controller has finished presenting
        }
    }
    
}

