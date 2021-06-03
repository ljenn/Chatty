//
//  CheckProfileCollectionViewCell.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 6/3/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class CheckProfileCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var storyBackgroundColor: UIView!
    @IBOutlet weak var storyContent1: UILabel!
    @IBOutlet weak var storyPrompt1: UILabel!
    
    var story: Story! {
        didSet {
            self.updateUI()
        }
    }
    
    func updateUI() {
        if let story = story {
            storyBackgroundColor.backgroundColor = story.color
            storyPrompt1.text = story.prompt
            storyContent1.text = story.storyContent
        } else {
            storyBackgroundColor.backgroundColor = nil
            storyPrompt1.text = nil
            storyContent1.text = nil
        }
        
        storyBackgroundColor.layer.cornerRadius = 20.0
        storyBackgroundColor.layer.masksToBounds = true

    }
}
