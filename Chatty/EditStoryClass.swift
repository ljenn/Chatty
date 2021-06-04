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
            "ONE Prompt",
            "TWO Prompt",
            "THREE Prompt"
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
            EditStory(color: UIColor(red: 0.90, green: 0.71, blue: 0.98, alpha: 1.00), prompt: prompt1, storyContent: story1),
            EditStory(color: UIColor(red: 0.63, green: 0.86, blue: 0.98, alpha: 1.00), prompt: prompt2, storyContent: story2),
            EditStory(color: UIColor(red: 0.78, green: 0.98, blue: 0.71, alpha: 1.00), prompt: prompt3, storyContent: story3)]
    }
    
    

}
