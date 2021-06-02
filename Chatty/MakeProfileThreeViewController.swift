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

//not sure if UIScrollViewDelegate is needed
class MakeProfileThreeViewController: UIViewController {

    //user's profile info collected from previous screen
    var theName: String!
    var theStatus: String!
    var theMood: String!
    var theImage: PFFileObject!
    var theDOB: Date!
    

    
    
    @IBOutlet weak var menuView1: UIView!
    @IBOutlet weak var prompt1Label: UILabel!
    @IBOutlet weak var story1txt: UITextView!


    
   
    
    @IBOutlet weak var menuView2: UIView!
    @IBOutlet weak var prompt2Label: UILabel!
    @IBOutlet weak var story2txt: UITextView!
    
    
    @IBOutlet weak var menuView3: UIView!
    @IBOutlet weak var prompt3Label: UILabel!
    @IBOutlet weak var story3txt: UITextView!

    
    let storyPromptMenu1: DropDown = {
        let storyPromptMenu = DropDown()
        storyPromptMenu.dataSource = [
            "ONE Prompt",
            "TWO Prompt",
            "THREE Prompt"
        ]
        return storyPromptMenu
    }()

    let storyPromptMenu2: DropDown = {
        let storyPromptMenu = DropDown()
        storyPromptMenu.dataSource = [
            "ONE Prompt",
            "TWO Prompt",
            "THREE Prompt"
        ]
        return storyPromptMenu
    }()
    
    let storyPromptMenu3: DropDown = {
        let storyPromptMenu = DropDown()
        storyPromptMenu.dataSource = [
            "ONE Prompt",
            "TWO Prompt",
            "THREE Prompt"
        ]
        return storyPromptMenu
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        story1txt.layer.borderColor = UIColor.purple.cgColor
        story1txt.layer.borderWidth = 1
        story1txt.layer.cornerRadius = 10
        story1txt.layer.backgroundColor = UIColor(red: 0.90, green: 0.71, blue: 0.98, alpha: 1.00).cgColor
        
        
        story2txt.layer.borderColor = UIColor.blue.cgColor
        story2txt.layer.borderWidth = 1
        story2txt.layer.cornerRadius = 10
        story2txt.layer.backgroundColor = UIColor(red: 0.63, green: 0.86, blue: 0.98, alpha: 1.00).cgColor
        
        
        story3txt.layer.borderColor = UIColor.green.cgColor
        story3txt.layer.borderWidth = 1
        story3txt.layer.cornerRadius = 10
        story3txt.layer.backgroundColor = UIColor(red: 0.78, green: 0.98, blue: 0.71, alpha: 1.00).cgColor
       
        
        
    
        //menu1
        let gesture1 = UITapGestureRecognizer(target: self, action: #selector(didTapMenu1))
        gesture1.numberOfTouchesRequired = 1
        gesture1.numberOfTapsRequired = 1

        menuView1.addGestureRecognizer(gesture1)
        storyPromptMenu1.anchorView = menuView1
        menuView1.layer.borderWidth = 1
        menuView1.layer.borderColor = UIColor.lightGray.cgColor
        storyPromptMenu1.selectionAction = {index, title in
                self.prompt1Label.text = title
            }
    

        //menu2
        let gesture2 = UITapGestureRecognizer(target: self, action: #selector(didTapMenu2))
        gesture2.numberOfTouchesRequired = 1
        gesture2.numberOfTapsRequired = 1

        menuView2.addGestureRecognizer(gesture2)
        storyPromptMenu2.anchorView = menuView2
        menuView2.layer.borderWidth = 1
        menuView2.layer.borderColor = UIColor.lightGray.cgColor
        storyPromptMenu2.selectionAction = {index, title in
                self.prompt2Label.text = title
            }
    
    
        //menu3
        let gesture3 = UITapGestureRecognizer(target: self, action: #selector(didTapMenu3))
        gesture3.numberOfTouchesRequired = 1
        gesture3.numberOfTapsRequired = 1
    
        menuView3.addGestureRecognizer(gesture3)
        storyPromptMenu3.anchorView = menuView3
        menuView3.layer.borderWidth = 1
        menuView3.layer.borderColor = UIColor.lightGray.cgColor
        storyPromptMenu3.selectionAction = {index, title in
                self.prompt3Label.text = title
            }

    }
    
    
    @objc func didTapMenu1(){
        storyPromptMenu1.show()
    }
    @objc func didTapMenu2(){
        storyPromptMenu2.show()
    }
    @objc func didTapMenu3(){
        storyPromptMenu3.show()
    }
    

    
    
    @IBAction func StartBTN(_ sender: Any) {
        

//      Create a Profile Class (for the new user who just signed up)
        let addedProfile = PFObject(className: "Profile")
        addedProfile["FirstN"] = theName
        //addedProfile["LastN"] = tfLast.text!
        addedProfile["Status"] = theStatus
        addedProfile["Mood"] = theMood
        
        addedProfile["Story1"] = story1txt.text
        addedProfile["Prompt1"] = prompt1Label.text
        
        addedProfile["Story2"] = story2txt.text
        addedProfile["Prompt2"] = prompt2Label.text
        
        addedProfile["Story3"] = story3txt.text
        addedProfile["Prompt3"] = prompt3Label.text
        
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
