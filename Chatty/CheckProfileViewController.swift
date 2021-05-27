//
//  CheckProfileViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/26/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class CheckProfileViewController: UIViewController {

    
    var profileID = ""
    @IBOutlet weak var FirstNCheck: UILabel!
    
    @IBOutlet weak var ageCheck: UILabel!
    
    @IBOutlet weak var statusCheck: UILabel!
    
    @IBOutlet weak var emojiCheck: UIImageView!
    
    @IBOutlet weak var moodCheck: UILabel!
    
    @IBOutlet weak var storiesCheck: UILabel!
    
    @IBOutlet weak var imgCheck: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


                let query = PFQuery(className: "Profile")
                query.includeKey("owner")
                query.whereKey("objectId", equalTo: profileID)

                query.findObjectsInBackground { (ProfileArray, error) in
                    if ProfileArray != nil{
                        let foundProfile = ProfileArray![0]

                        self.FirstNCheck.text = foundProfile["FirstN"] as? String
                        
                        self.statusCheck.text = foundProfile["Status"] as? String
                        
                        let moodtxt = foundProfile["Mood"] as? String
                        self.moodCheck.text = moodtxt
                        self.emojiCheck.image = UIImage(named: moodtxt!)
                        
        
                        let imageFile = foundProfile["Picture"] as! PFFileObject
                        let imgURL = imageFile.url!
                        let profileURL = URL(string: imgURL)!
                        self.imgCheck.af.setImage(withURL: profileURL)



                    }else{
                        print("Error fetching profile: \(error?.localizedDescription)")
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
