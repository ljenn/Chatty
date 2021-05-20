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
    
    @IBOutlet weak var labelLast: UILabel!
    
    @IBOutlet weak var labelStory: UILabel!
    
    @IBOutlet weak var labelStatus: UILabel!
    
    
    
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
                self.labelLast.text = myProfile["LastN"] as? String
                self.labelStatus.text = myProfile["Status"] as? String
                
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
