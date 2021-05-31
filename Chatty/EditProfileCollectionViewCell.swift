//
//  EditProfileCollectionViewCell.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/31/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class EditProfileCollectionViewCell: UICollectionViewCell {
    
    
    
    @IBOutlet weak var editStoryTF: UITextField!
    
    @IBOutlet weak var editMenuView: UIView!
    
    @IBOutlet weak var editEmojiIMG: UIImageView!
    
    @IBOutlet weak var editDropdownLabel: UILabel!
    
    @IBOutlet weak var storyBackgroundColor: UIView!
    
    
    var story: Story! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let story = story {
            storyBackgroundColor.backgroundColor = story.color
            editDropdownLabel.text = story.prompt
            editStoryTF.text = story.storyContent
        } else {
            storyBackgroundColor.backgroundColor = nil
            editDropdownLabel.text = nil
            editStoryTF.text = nil
        }
        
        storyBackgroundColor.layer.cornerRadius = 20.0
        storyBackgroundColor.layer.masksToBounds = true

    }
    
}
