//
//  DetailProfileViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/18/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import AlamofireImage


class DetailProfileViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {


    var tappedProfile = PFObject(className: "Profile")
    

    @IBOutlet weak var StoryTV: UITableView!

    @IBOutlet weak var ChatWithMeBTN: UIButton!
    @IBOutlet weak var imgDP: UIImageView!
    @IBOutlet weak var firstDP: UILabel!
    @IBOutlet weak var lastDP: UILabel!
    @IBOutlet weak var statusDP: UILabel!
    @IBOutlet weak var moodDP: UILabel!
    @IBOutlet weak var emojiDP: UIImageView!
    
    
    
    
    @IBOutlet weak var cellHeight: NSLayoutConstraint!



    override func viewDidLoad() {
        super.viewDidLoad()

//        let storiesList = tappedProfile["Stories"] as! [String]
//        let count = storiesList.count
//        cellHeight.constant = CGFloat(Double(count) * 50)





        //set display attributes

        let firstname = tappedProfile["FirstN"] as? String
        firstDP.text = firstname
        lastDP.text = tappedProfile["LastN"] as? String
        statusDP.text = tappedProfile["Status"] as? String
        
        let moodTXT = tappedProfile["Mood"] as? String
        moodDP.text = moodTXT
        emojiDP.image = UIImage(named: moodTXT!)
        

        let imageFile = tappedProfile["Picture"] as! PFFileObject
        let imageURL = imageFile.url!
        let ProfileImgURL = URL(string: imageURL)!
        imgDP.af.setImage(withURL: ProfileImgURL)

        //set up button
        ChatWithMeBTN.layer.cornerRadius = 5
        ChatWithMeBTN.layer.borderWidth = 1
        ChatWithMeBTN.layer.borderColor = UIColor.brown.cgColor
            ChatWithMeBTN.setTitle("Chat with " + firstname!, for: .normal)

        //set up to display list of stories
        StoryTV.delegate = self
        StoryTV.dataSource = self
        StoryTV.reloadData()

    }
    
    
    // Not working!! To be deleted    VVVVVVVVVVV
//    override func viewWillAppear(_ animated: Bool) {
//        self.StoryTV.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
//        self.StoryTV.reloadData()
//    }
//
//    override func viewWillDisappear(_ animated: Bool) {
//        self.StoryTV.removeObserver(self, forKeyPath: "contentSize")
//    }
//
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
//        if keyPath == "contentSize"{
//            if object is UITableView{
//                if let newvalue = change?[.newKey]{
//                    let newsize = newvalue as! CGSize
//                    self.cellHeight.constant = newsize.width
//                }
//            }
//        }
//    }


    //^^^^^^^^
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let storiesList = tappedProfile["Stories"] as! [String]
        return storiesList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let storiesList = tappedProfile["Stories"] as! [String]
        let singleStory = storiesList[indexPath.row]

        let storyCell = StoryTV.dequeueReusableCell(withIdentifier: "StoryCellTableView") as! StoryCellTableView
        storyCell.SingleStoryContext.text = singleStory

        return storyCell
    }



    @IBAction func ChatBtnFxn(_ sender: Any) {

        //add profile to friend list (later in homefeed, filter out friended profile)
        //userA = current User   &&   userB = the new friend


        let mutualConvo = PFObject(className: "Conversation")

        //var currentUserProfile = PFObject(className: "Profile")

        var currentUserProfile: PFObject!  //Credit to Jenny!!!

        //Part1: update info in current user's profile
        //a) find userA profile
        //b) add userB's objId to userA's freindlist
        //c) add the new convo to the chatlist of userA profile
        let queryA = PFQuery(className: "Profile")
        queryA.whereKey("owner", equalTo: PFUser.current() as Any)
        queryA.findObjectsInBackground { (resultArray, error) in
            if resultArray != nil{
                if resultArray!.count == 1{
//                    let currentUserProfile = resultArray![0]
                    currentUserProfile = resultArray![0]
//                    currentUserProfile.add(self.tappedProfile["owner"] as! PFUser, forKey: "FriendList")
                    currentUserProfile.add(self.tappedProfile, forKey: "FriendList")
                    currentUserProfile.add(mutualConvo, forKey: "Chats")
                    currentUserProfile.saveInBackground()

                    mutualConvo.add(currentUserProfile,forKey: "Participants")

                }
            }else{
                print("Error locating the profile: \(error?.localizedDescription)")
            }
        }



        //Part2: update info in friend's profile
        //a) find userB profile
        //b) add userA's objId to userB's freindlist
        //c) add the new convo to the chatlist of userB profile
        let queryB = PFQuery(className: "Profile")
        queryB.whereKey("owner", equalTo: tappedProfile["owner"] as! PFUser)
        queryB.findObjectsInBackground { (resultArray, error) in
            if resultArray != nil{
                if resultArray!.count >= 1{
                    let FriendProfile = resultArray![0]
                    //FriendProfile.add(PFUser.current(), forKey: "FriendList")
                    FriendProfile.add(currentUserProfile, forKey:"FriendList")
                    FriendProfile.add(mutualConvo, forKey: "Chats")
                    FriendProfile.saveInBackground()

                    mutualConvo.add(FriendProfile, forKey: "Participants")
                }
            }else{
                print("Error locating the profile: \(error?.localizedDescription)")
            }
        }

    }

}
