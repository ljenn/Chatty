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

class HomeCellTableView: UITableViewCell {
    
    //each cell displays a profile on the home page (table of profiles) 
    
    @IBOutlet weak var imgHomeCell: UIImageView!
    
    @IBOutlet weak var firstNHomeCell: UILabel!
    
    @IBOutlet weak var statusHomeCell: UILabel!
    
    @IBOutlet weak var emoji: UIImageView!
    
    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var ageCell: UILabel!
    
    @IBOutlet weak var chatBTN: UIButton!
    
    @IBOutlet weak var storyContentView: UIView!
    
    var currentIndex = 0
    var storyArray: [String]?
    
    var storyPgVC: StoryPageViewController?
    
    
    //noNeed!!
    //var userProfile = PFObject(className: "Profile")  //mine
    var cellProfile = PFObject(className: "Profile")  //friend's
    var homeVC: HomeViewController!
    var capturedTxt: String!
    
    
    var dummySource = ["PG1","PG2","PG3","PG4"]
    
    
    
    
    @IBAction func clickedChatBTN(_ sender: Any) {
        //btn logic here
        homeVC.showMsgBar = true
        homeVC.becomeFirstResponder()
        homeVC.myMessageBar.inputTextView.becomeFirstResponder()
        homeVC.selectedProfile = cellProfile
    }
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code

        
        
        
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    //configure in cell, homevc inherit delegate (delegate to homevc)
    //all parameters can be directly accessed here.
    func configureMyPgViewController(){

        
        guard let storyPgVC = homeVC.storyboard?.instantiateViewController(withIdentifier: "StoryPageViewController") as? StoryPageViewController else{
            return
        }
        
        storyPgVC.delegate = self
        storyPgVC.dataSource = self
        
        homeVC.addChild(storyPgVC)
        storyPgVC.didMove(toParent: homeVC)
        
        //configuring layout:
        storyPgVC.view.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: CHECKK!! which view to add
        storyContentView.addSubview(storyPgVC.view)
        //contentView.addSubview(storyPgVC.view)
        
        let views: [String: Any] = ["pageView": storyPgVC.view]
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-0-[pageView]-0-|",
                                                                 options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: views))
        
        contentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-0-[pageView]-0-|",
                                                                 options: NSLayoutConstraint.FormatOptions(rawValue: 0),
                                                                 metrics: nil,
                                                                 views: views))
        
        guard let startingVC = StoryBoxVCAt(currentIDX: currentIndex) else{
            return
        }
        
        
        storyPgVC.setViewControllers([startingVC], direction: .forward, animated: true)
        
        
    }
    
    
    func StoryBoxVCAt(currentIDX: Int) -> StoryBoxViewController?{
        
        //MARK: change count!!
//        if currentIDX >= storiesArray.count || storiesArray.count == 0 {
//            return nil
//        }
        if currentIDX >= dummySource.count || dummySource.count == 0 {
                return nil
            }
        
        
        guard let storyboxVC = homeVC.storyboard?.instantiateViewController(withIdentifier: "StoryBoxViewController") as? StoryBoxViewController else{
            return nil
        }
        
    
        storyboxVC.index = currentIDX
        
        //MARK: change datasoure!!
        //storyboxVC.storyContent = storiesArray[currentIDX]
        storyboxVC.storyContent = dummySource[currentIDX]
        
        
        
        return storyboxVC
    }
    

}

//delegate = passed in homevc.
//override the function so it knows myCell?
extension HomeCellTableView: UIPageViewControllerDataSource,UIPageViewControllerDelegate{
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        return currentIndex
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        //MARK: TODO
        return dummySource.count
        //return storyArray?.count ?? 0
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let myStoryBoxVC = viewController as? StoryBoxViewController
        
        guard var curIndex = myStoryBoxVC?.index else{
            return nil
        }
        
        currentIndex = curIndex
        
        if curIndex == 0{
            return nil
        }
        
        curIndex -= 1
        
        return StoryBoxVCAt(currentIDX: curIndex)
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let myStoryBoxVC = viewController as? StoryBoxViewController
        
        guard var curIndex = myStoryBoxVC?.index else{
            return nil
        }
        
        //MARK: TODO
//        if curIndex == storyArray?.count{
//            return nil
//        }
        
        if curIndex == dummySource.count{
            return nil
        }
        
        
        
        curIndex += 1
        
        currentIndex = curIndex
        
        return StoryBoxVCAt(currentIDX: curIndex)
        
    }
    
    
    
}

