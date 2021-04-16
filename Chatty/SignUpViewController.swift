//
//  SignUpViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/12/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {

    @IBOutlet weak var tfSignupUser: UITextField!
    
    @IBOutlet weak var tfSignupPassword: UITextField!
    
    @IBOutlet weak var tfSignupEmail: UITextField!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    //sign up with Parse function
    @IBAction func btnCreateAcct(_ sender: Any) {
        
        let user = PFUser()
        user.username = tfSignupUser.text!
        user.password = tfSignupPassword.text!
        user.email = tfSignupEmail.text!

        user.signUpInBackground { (success, error) in
            if success{
                print("Signed Up successfully!")
                self.performSegue(withIdentifier: "toMakeProfileSegue", sender: self)
                
            } else{
                print("Error Signing Up: \(error?.localizedDescription)")
                self.view.makeToast(error?.localizedDescription)
            }
        }
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
