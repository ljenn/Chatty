//
//  MakeProfileThreeViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/24/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import DropDown

class MakeProfileThreeViewController: UIViewController {

    //user's profile info collected from previous screen
    var theName: String!
    var theStatus: String!
    var theMood: String!
    var theImage: PFFileObject!
    var theDOB: Date!
    
    @IBOutlet weak var tfStory: UITextField!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    @IBAction func StartBTN(_ sender: Any) {
        

//      Create a Profile Class (for the new user who just signed up)
        let addedProfile = PFObject(className: "Profile")
        addedProfile["FirstN"] = theName
        //addedProfile["LastN"] = tfLast.text!
        addedProfile["Status"] = theStatus
        addedProfile["Mood"] = theMood
        
        //the story field is an array, but now chaning to String
        //addedProfile.add(tfStory.text!,forKey: "Stories")
        addedProfile["Story1"] = tfStory.text
        
        addedProfile["owner"] = PFUser.current()!
        addedProfile["Picture"] = theImage
        addedProfile["Birthday"] = theDOB
        
        print(abs(Int(theDOB.timeIntervalSinceNow/31556926.0)))

        addedProfile.saveInBackground { (success, error) in
        if success{

            //show next veiwController on a different screen :(
//            print("profile saved successfully")
//            self.performSegue(withIdentifier: "ProfileToMainSegue", sender: self)

            //show the next viewController on the "same page"
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let secondVC = storyboard.instantiateViewController(identifier: "CenterNavigationController") //storyboardID

            secondVC.modalPresentationStyle = .fullScreen
            secondVC.modalTransitionStyle = .crossDissolve

            self.present(secondVC, animated: true, completion: nil)
        } else {
            print("Error saving profile: \(error?.localizedDescription)")
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
