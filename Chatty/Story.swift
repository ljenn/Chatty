//
//  Story.swift
//  Chatty
//
//  Created by Jenny Lee on 5/29/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class Story {
    var prompt = ""
    var storyContent = ""
    var color: UIColor
    
    init(color: UIColor, prompt: String, storyContent: String) {
        self.color = color
        self.prompt = prompt
        self.storyContent = storyContent
    }
    
    
    //with parameters: stories are not necessarily 3, can be any count.
    static func getedStories(promptList: [String], storyList: [String]) -> [Story] {
        
        var storyObjects = [Story]()
        
        for i in 0...storyList.count-1{
            var cellColor = UIColor()
            switch i {
            case 0:
                cellColor = UIColor.systemIndigo
            case 1:
                cellColor = UIColor.systemBlue
            default:
                cellColor = UIColor.systemGreen
            }
            
            storyObjects.append(Story(color: cellColor, prompt: promptList[i], storyContent: storyList[i]))
            
        }
        
        return storyObjects
    }
    
    
    
//    static func getStories() -> [Story] {
//
//        //get data;
//        //put data into var
//        //replace string in return array with variable
//
//        return [
//            Story(color: UIColor.systemIndigo, prompt: "greatest day ever", storyContent: "greatest day? lol i dont have any jk i just honestly cant remember right now so idk"),
//            Story(color: UIColor.systemBlue, prompt: "worst day ever", storyContent: "well thinking of prompts is honestly super hard. i want to watch tv and eat and sleep. yup."),
//            Story(color: UIColor.systemGreen, prompt: "choose something", storyContent: "i choose bread!! and rice. carbs ftw yay!")]
//    }
}
