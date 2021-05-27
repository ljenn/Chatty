//
//  HomeCellTableView.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/15/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse

class HomeCellTableView: UITableViewCell {
    
    //each cell displays a profile on the home page (table of profiles) 
    
    @IBOutlet weak var imgHomeCell: UIImageView!
    
    @IBOutlet weak var firstNHomeCell: UILabel!
    
    @IBOutlet weak var statusHomeCell: UILabel!
    
    @IBOutlet weak var storyHomeCell: UILabel!
    
    @IBOutlet weak var emoji: UIImageView!
    
    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var ageCell: UILabel!
    
    @IBOutlet weak var chatBTN: UIButton!
    
    
    //var cellProfile: PFObject!
    var userProfile = PFObject(className: "Profile")
    var cellProfile = PFObject(className: "Profile")
    
    
    
    @IBAction func clickedChatBTN(_ sender: Any) {
        //btn logic here
        print(firstNHomeCell.text)
        
        //creat convo, add to convo list.
        //add msg to convo
        //show Toast
        //add to friend list -> remove profile (by reloading data).
        
        //need: Profile of both users, message txt.
        
        
    }
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
