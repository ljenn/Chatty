//
//  ProfileTabViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/13/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

class ProfileTabViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    
    @IBOutlet weak var labelFirst: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    @IBOutlet weak var labelStory: UILabel!
    
    @IBOutlet weak var labelStatus: UILabel!
    
    @IBOutlet weak var moodIMG: UIImageView!
    
    @IBOutlet weak var moodTXT: UILabel!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetch the current user's profile and display on the user's profile page.
        
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        
        query.whereKey("owner", equalTo: PFUser.current() as Any)
        query.findObjectsInBackground { (ArrayOfProfiles, error) in
            if ArrayOfProfiles != nil{
                let myProfile = ArrayOfProfiles![0]
                self.labelFirst.text = myProfile["FirstN"] as? String
                self.labelStatus.text = myProfile["Status"] as? String
                
                let fetchedDate = myProfile["Birthday"] as? Date
                let ageNum = abs(Int(fetchedDate!.timeIntervalSinceNow/31556926.0))
                self.ageLabel.text = String(ageNum)
              
                let myMoodName = myProfile["Mood"] as? String
                self.moodTXT.text = myMoodName
                self.moodIMG.image = UIImage(named: myMoodName!)
                

                let imageFile = myProfile["Picture"] as! PFFileObject
                let imageURL = imageFile.url!
                let ProfileImgURL = URL(string: imageURL)!
                self.imgProfile.af.setImage(withURL: ProfileImgURL)
            }else{
                print("Error fetching profile: \(error?.localizedDescription)")
            }
        }

    }
    

}
