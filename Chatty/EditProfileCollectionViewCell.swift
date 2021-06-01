//
//  EditProfileCollectionViewCell.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/31/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class EditProfileCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var editStoryTF: UITextView!
    
    @IBOutlet weak var editMenuView: UIView!
    
    @IBOutlet weak var editEmojiIMG: UIImageView!
    
    @IBOutlet weak var editDropdownLabel: UILabel!
    
    @IBOutlet weak var storyBackgroundColor: UIView!
    
    @IBOutlet weak var saveStoryButton: UIButton!
    
    
    
    
    
    
    
    
    @IBAction func uponSavingStory(_ sender: Any) {
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
