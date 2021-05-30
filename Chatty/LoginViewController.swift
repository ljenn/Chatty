//
//  LoginViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/12/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import Toast_Swift

class LoginViewController: UIViewController {
    
    @IBOutlet weak var tfUsername: UITextField!
    
    @IBOutlet weak var tfPassword: UITextField!
    
    
    @IBOutlet weak var kiteStackViewLogin: UIStackView!
    

    @IBOutlet weak var loginContainerConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var loginStackViewConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loginContainerConstraint.constant -= view.bounds.height
        loginStackViewConstraint.constant -= view.bounds.height
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        cloudAnimation()
        
        loginStackViewConstraint.constant = 0
        UIView.animate(withDuration: 3.0) { [weak self] in
          self?.view.layoutIfNeeded()
        }
        loginContainerConstraint.constant = 0
        UIView.animate(withDuration: 3.0) { [weak self] in
          self?.view.layoutIfNeeded()
        }
        
        
    }
    
    // Animation
    
    private func cloudAnimation() {
      let options: UIView.AnimationOptions = [.curveEaseInOut, .repeat, .autoreverse]

        UIView.animate(withDuration: 3.0,
                       delay: 0,
                       options: options,
                       animations: { [weak self] in
                        self?.kiteStackViewLogin.frame.size.height *= 1.15
                        self?.kiteStackViewLogin.frame.size.width *= 1.15
        }, completion: nil)
    }
    
    
    //Login with Parse function
    @IBAction func btnLogin(_ sender: Any) {
        let username = tfUsername.text!
        let password = tfPassword.text!
        
        PFUser.logInWithUsername(inBackground: username, password: password) { (attemptedUser, error) in
            if attemptedUser != nil{
                //user found!
//                print("Login Successfully")
//                self.performSegue(withIdentifier: "toMainSegue", sender: self)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let secondVC = storyboard.instantiateViewController(identifier: "CenterNavigationController")

                secondVC.modalPresentationStyle = .fullScreen
                secondVC.modalTransitionStyle = .crossDissolve

                self.present(secondVC, animated: true, completion: nil)
                
            }else{
                print("Error Logging in: \(error?.localizedDescription)")
                self.view.makeToast(error?.localizedDescription)
            }
        }
    }
    
    
    @IBAction func btnSignup(_ sender: Any) {
        //the button is for guiding user to the sign up page
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
