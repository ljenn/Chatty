//
//  HomeViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/12/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse



class HomeViewController: UIViewController {
    
  
    

    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func btnLogout(_ sender: Any) {
        
        PFUser.logOut()

        let main = UIStoryboard(name: "Main", bundle: nil)
        let LoginStoryBoard = main.instantiateViewController(identifier: "LoginStoryBoard")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}

        delegate.window?.rootViewController = LoginStoryBoard
        
            
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
