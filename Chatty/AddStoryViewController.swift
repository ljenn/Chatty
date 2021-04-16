//
//  AddStoryViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/15/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse

class AddStoryViewController: UIViewController {

    @IBOutlet weak var addStoryTF: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    @IBAction func AddStoryBTN(_ sender: Any) {
        
        let storyDetail = addStoryTF.text
        
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        query.whereKey("owner", equalTo: PFUser.current() as Any)
        
        query.findObjectsInBackground { (arrayOfResult, error) in
            if arrayOfResult != nil{
                if arrayOfResult!.count >= 1{
                    let profileToUpdate = arrayOfResult![0]
                    profileToUpdate.add(storyDetail as Any, forKey: "Stories")
                    profileToUpdate.saveInBackground()
                    print("New story saved to database!")
                    self.addStoryTF.text = ""
                    self.view.makeToast("Saved!")
                }else{
                    print("Error saving story to database: \(error?.localizedDescription)")
                    self.view.makeToast("Fail to save story")
                }
                
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
