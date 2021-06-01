//
//  EditProfileCollectionViewCell.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/31/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import Toast_Swift

class EditProfileCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var editStoryTF: UITextView!
    
    @IBOutlet weak var editMenuView: UIView!
    
    @IBOutlet weak var editEmojiIMG: UIImageView!
    
    @IBOutlet weak var editDropdownLabel: UILabel!
    
    @IBOutlet weak var storyBackgroundColor: UIView!
    
    @IBOutlet weak var saveStoryButton: UIButton!
    
    
    var myIndex: Int!
    var parentVC: EditProfileViewController!
    
    
    
    
    @IBAction func uponSavingStory(_ sender: Any) {
 
        //query then save into in corresponding column(index)
        
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        query.whereKey("owner", equalTo: PFUser.current() as Any)

        query.findObjectsInBackground { (ProfileArray, error) in
            if ProfileArray != nil{
                let profileToUpdate = ProfileArray![0]
                
                
                //Step1: record story
                let storyText = self.editStoryTF.text
                let promtText = self.editDropdownLabel.text
                
                switch self.myIndex {
                    case 0:
                        profileToUpdate["Story1"] = storyText
                        profileToUpdate["Prompt1"] = promtText
                    
                    case 1:
                        profileToUpdate["Story2"] = storyText
                        profileToUpdate["Prompt2"] = promtText
                    case 2:
                        profileToUpdate["Story3"] = storyText
                        profileToUpdate["Prompt3"] = promtText
                    default:
                        self.parentVC.view.makeToast("Fail to update story!")
                        break
                }
               
                profileToUpdate.saveInBackground()
                self.parentVC.view.makeToast("Story Saved!") //essentially saving the whole profile, not only the story
                
                //update text in collection view
                self.editStoryTF.text = storyText
                
        
            }
        }
    }
    
    
    
    
    var edStory: EditStory! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let edStory = edStory {
            storyBackgroundColor.backgroundColor = edStory.color
            editDropdownLabel.text = edStory.prompt
            editStoryTF.text = edStory.storyContent
        } else {
            storyBackgroundColor.backgroundColor = nil
            editDropdownLabel.text = nil
            editStoryTF.text = nil
        }
        
        storyBackgroundColor.layer.cornerRadius = 20.0
        storyBackgroundColor.layer.masksToBounds = true
        
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        editMenuView.addGestureRecognizer(gesture)
        
        edStory.storyPromptMenu.anchorView = editMenuView
        editMenuView.layer.borderWidth = 1
        editMenuView.layer.borderColor = UIColor.systemTeal.cgColor
        
        edStory.storyPromptMenu.selectionAction = {index, title in
                //print("index \(index) and \(title)")
            self.edStory.prompt = title
            self.updateUI()
        }
        
        

    }
    
    @objc func didTapMenu(){
        edStory.storyPromptMenu.show()
    }
    
}
