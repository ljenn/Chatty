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
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()


                let query = PFQuery(className: "Profile")
                query.includeKey("owner")
                query.whereKey("objectId", equalTo: profileID)

                query.findObjectsInBackground { (ProfileArray, error) in
                    if ProfileArray != nil{
                        let foundProfile = ProfileArray![0]

                        print("incheck \(foundProfile["FirstN"])")

                        self.FirstNCheck.text = foundProfile["FirstN"] as? String
                        //self.firstDP.text = foundProfile["FirstN"] as? String
        //                self.statusDP.text = foundProfile["Status"] as? String
        //                self.moodDP.text = foundProfile["Mood"] as? String
        //
        //                let imageFile = foundProfile["Picture"] as! PFFileObject
        //                let imgURL = imageFile.url!
        //                let profileURL = URL(string: imgURL)!
        //                self.imgDP.af.setImage(withURL: profileURL)



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
