//
//  StoryBoxViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/28/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit

class StoryBoxViewController: UIViewController {

    @IBOutlet weak var storytxtLabel: UILabel!
    var storyContent: String?
    var index: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        storytxtLabel.text = storyContent

        // Do any additional setup after loading the view.
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


