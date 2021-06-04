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
    
    //user's profile info collected from previous screen
    var myName: String!
    var myImage: PFFileObject!
    var myDOB: Date!

    
    
    @IBOutlet weak var emoji: UIImageView!
    
    @IBOutlet weak var tfStatus: UITextField!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var moodLabel: UILabel!
    

    
    let moodMenu: DropDown = {
        let moodMenu = DropDown()
        moodMenu.dataSource = [
            "Hustling",
            "Wild",
            "Outdoorsy",
            "Hungry",
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
    }
}

    @objc func didTapMenu(){
        moodMenu.show()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "toProfileThreeSegue") {
            if let nextViewController = segue.destination as? MakeProfileThreeViewController {
                nextViewController.theName = myName
                nextViewController.theDOB = myDOB
                nextViewController.theImage = myImage
                nextViewController.theMood = moodLabel.text
                nextViewController.theStatus = tfStatus.text
             }
        }
    }
    
    
    
    
    @IBAction func ContinueII(_ sender: Any) {
        performSegue(withIdentifier: "toProfileThreeSegue", sender: self)
        
    }
    
    

    
    
    
    

}
