//
//  ViewController.swift
//  fbook
//
//  Created by Yagiz Ozturk on 8.06.2022.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func signin(_ sender: Any) {
        if emailText.text! != "" || passwordText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: passwordText.text!) { authdataresult, error in
                if error != nil {
                    self.Error(titleInput: "Error", messageInput: error?.localizedDescription ?? "Please try again !")
                } else {
                    self.performSegue(withIdentifier: "tofeedvc", sender: nil)
                }
            }
        } else {
            self.Error(titleInput: "Error !", messageInput: "E-mail or password can't left empty !")
        }
        
        
    }
    @IBAction func signup(_ sender: Any) {

        if emailText.text != "" || passwordText.text != ""{
            Auth.auth().createUser(withEmail: emailText.text!, password: passwordText.text!) { (authdataresult, error) in
                if error != nil {
                    self.Error(titleInput: "Error", messageInput: error?.localizedDescription ?? "Please try again !")
                } else {
                    self.performSegue(withIdentifier: "tofeedvc", sender: nil)
                }
            }
        } else {
            Error(titleInput: "Error !", messageInput: "E-mail or password can't left empty !")
            
        }
    }
    func Error(titleInput: String, messageInput: String) {
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
}

