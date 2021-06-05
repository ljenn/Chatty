//
//  EditStoryClass.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/31/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import DropDown

class EditStory {
    var prompt = ""
    var storyContent = ""
    var color: UIColor
    
    let storyPromptMenu: DropDown = {
        let storyPromptMenu = DropDown()
        storyPromptMenu.dataSource = [
            "Last week...",
            "My happiest moment was when...",
            "An embarrassing story:",
            "The one time I was a genius:",
            "My most miraculous story:",
            "I did this, but never again.",
            "Best vacation EVER:",
            "Tell me a story that should be illegal but isn't."
        ]
        return storyPromptMenu
    }()
    
    

    
    init(color: UIColor, prompt: String, storyContent: String) {
        self.color = color
        self.prompt = prompt
        self.storyContent = storyContent
    }

    
    //with parameters: will always have 3 columns for stories. 
    static func getedStories(prompt1: String, prompt2: String, prompt3: String, story1: String, story2: String, story3: String) -> [EditStory] {
        
        //get data;
        //put data into var
        //replace string in return array with variable
        
        return [
            EditStory(color: UIColor(red: 0.87, green: 0.92, blue: 1.00, alpha: 1.00), prompt: prompt1, storyContent: story1),
            EditStory(color: UIColor(red: 0.87, green: 0.92, blue: 1.00, alpha: 1.00), prompt: prompt2, storyContent: story2),
            EditStory(color: UIColor(red: 0.87, green: 0.92, blue: 1.00, alpha: 1.00), prompt: prompt3, storyContent: story3)]
    }
    
    

}
