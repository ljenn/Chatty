//
//  LoginViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/12/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {


    @IBOutlet weak var tfUsername: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnLogin(_ sender: Any) {
        let username = tfUsername.text!
        let password = tfPassword.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (attemptedUser, error) in
            if attemptedUser != nil{
                //user found!
                print("Login Successfully")
                self.performSegue(withIdentifier: "toMainSegue", sender: self)
            }else{
                print("Error Logging in: \(error?.localizedDescription)")
            }
        }
    }
    
    
    @IBAction func btnSignup(_ sender: Any) {
        let user = PFUser()
        user.username = tfUsername.text
        user.password = tfPassword.text
        
        user.signUpInBackground { (success, error) in
            if success{
                print("Signed Up successfully!")
                self.performSegue(withIdentifier: "toMainSegue", sender: self)
            } else{
                print("Error Signing Up: \(error?.localizedDescription)")
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
