//
//  HomeCellTableView.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/15/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import InputBarAccessoryView

class HomeCollectionViewCell: UICollectionViewCell {
    
    //each cell displays a profile on the home page (table of profiles) 
    @IBOutlet var CellScrollV: UIScrollView!
    @IBOutlet weak var imgHomeCell: UIImageView!
    @IBOutlet weak var chatBTN: UIButton!
    
    @IBOutlet weak var statusHomeCell: UILabel!
    @IBOutlet weak var ageCell: UILabel!
    @IBOutlet weak var firstNHomeCell: UILabel!
    @IBOutlet weak var moodLabel: UILabel!
//    @IBOutlet weak var imgHomeCell: UIImageView!
    @IBOutlet weak var emoji: UIImageView!
    
//    @IBOutlet weak var firstNHomeCell: UILabel!
//
//    @IBOutlet weak var statusHomeCell: UILabel!
//
//    @IBOutlet weak var emoji: UIImageView!
//
//    @IBOutlet weak var moodLabel: UILabel!
//
//    @IBOutlet weak var ageCell: UILabel!
    
//    @IBOutlet weak var chatBTN: UIButton!
    
//    @IBOutlet var CellScrollV: UIScrollView!

//    @IBOutlet var pgControl: UIPageControl!
    @IBOutlet var pgControl: UIPageControl!
    
    var storyArray = [String]()
    var promptArray = [String]()
    
    

    var cellProfile = PFObject(className: "Profile")  //friend's
    var homeVC: HomeViewController!
    var capturedTxt: String!
    
    
    

    
    @IBAction func clickedChatBTN(_ sender: Any) {
        //btn logic here
        homeVC.showMsgBar = true
        homeVC.becomeFirstResponder()
        homeVC.myMessageBar.inputTextView.becomeFirstResponder()
        homeVC.selectedProfile = cellProfile
    }
    
//    @IBAction func clickedChatBTN(_ sender: Any) {
//        //btn logic here
//        homeVC.showMsgBar = true
//        homeVC.becomeFirstResponder()
//        homeVC.myMessageBar.inputTextView.becomeFirstResponder()
//        homeVC.selectedProfile = cellProfile
//    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

//        CellScrollV = UIScrollView(frame: CGRect(x: 0, y: 0, width: 320, height: 150))
//        CellScrollV.backgroundColor = UIColor.lightGray
//        CellScrollV.indicatorStyle = .black
//        CellScrollV.showsHorizontalScrollIndicator = false
//        CellScrollV.delegate = homeVC
//
//        CellScrollV.showsVerticalScrollIndicator = true
//        CellScrollV.bounces = true
//        CellScrollV.isPagingEnabled = true
//        CellScrollV.contentSize = CGSize(width: 640, height: 30)
//        
//        pgControl = UIPageControl(frame: CGRect(x: 0, y: 155, width: 320, height: 40))
//        pgControl.numberOfPages = storyArray.count //?? 0
//        pgControl.currentPage = 0
////        myCell.pgControl.backgroundColor = UIColor.red
////        myCell.pgControl.tintColor = UIColor.white
//        pgControl.backgroundColor = UIColor.clear
//        pgControl.tintColor = UIColor.clear
//        contentView.addSubview(pgControl)
        
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//
//        // Configure the view for the selected state
//    }
    
    
    
    
}

