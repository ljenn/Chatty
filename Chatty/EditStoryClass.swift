//
//  EditStoryClass.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/31/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import Foundation
import UIKit


class EditStory {
    var prompt = ""
    var storyContent = ""
    var color: UIColor
    
    init(color: UIColor, prompt: String, storyContent: String) {
        self.color = color
        self.prompt = prompt
        self.storyContent = storyContent
    }
    
    static func getStories() -> [Story] {
        
        //get data;
        //put data into var
        //replace string in return array with variable
        
        return [
            Story(color: UIColor.systemIndigo, prompt: "greatest day ever", storyContent: "greatest day? lol i dont have any jk i just honestly cant remember right now so idk"),
            Story(color: UIColor.systemBlue, prompt: "worst day ever", storyContent: "well thinking of prompts is honestly super hard. i want to watch tv and eat and sleep. yup."),
            Story(color: UIColor.systemGreen, prompt: "choose something", storyContent: "i choose bread!! and rice. carbs ftw yay!")]
    }
}

