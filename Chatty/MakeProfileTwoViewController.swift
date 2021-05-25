//
//  MakeProfileTwoViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/24/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import DropDown


class MakeProfileTwoViewController: UIViewController {
    
    
    
    @IBOutlet weak var tfStatus: UITextField!
    @IBOutlet weak var tfStory: UITextField!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var emoji: UIImageView!
    @IBOutlet weak var moodLabel: UILabel!
    
    
    
    let moodMenu: DropDown = {
        let moodMenu = DropDown()
        moodMenu.dataSource = [
            "Studying",
            "Partying",
            "Exercising",
            "Eating",
        ]
        return moodMenu
    }()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        menuView.addGestureRecognizer(gesture)
        moodMenu.anchorView = menuView
        menuView.layer.borderWidth = 1
        menuView.layer.borderColor = UIColor.lightGray.cgColor

        moodMenu.selectionAction = {index, title in
            //print("index \(index) and \(title)")
            self.moodLabel.text = title
            self.emoji.image = UIImage(named: title)

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

@objc func didTapMenu(){
    moodMenu.show()
}

}
