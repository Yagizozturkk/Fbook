//
//  SettingsVC.swift
//  fbook
//
//  Created by Yagiz Ozturk on 8.06.2022.
//

import UIKit
import Firebase
class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func exitButton(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "toexit", sender: nil)

        }catch {
            print("hatali")
        }
        
        performSegue(withIdentifier: "toexit", sender: nil)
    
    }
    
    
}
