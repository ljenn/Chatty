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


    var tappedProfile = PFObject(className: "Profile") //to be commented out
    var detailProfileID = ""
    //var currentUserProfile: PFObject!  //Credit to Jenny!!!
    

    @IBOutlet weak var StoryTV: UITableView!

    @IBOutlet weak var ChatWithMeBTN: UIButton!
    @IBOutlet weak var imgDP: UIImageView!
    @IBOutlet weak var firstDP: UILabel!
    @IBOutlet weak var ageDP: UILabel!
    @IBOutlet weak var statusDP: UILabel!
    @IBOutlet weak var moodDP: UILabel!
    @IBOutlet weak var emojiDP: UIImageView!
    
    
    
    
    @IBOutlet weak var cellHeight: NSLayoutConstraint!



    override func viewDidLoad() {
        super.viewDidLoad()




        //set display attributes

        let firstname = tappedProfile["FirstN"] as? String
        firstDP.text = firstname


        let fetchedDate = tappedProfile["Birthday"] as? Date
        let ageNum = abs(Int(fetchedDate!.timeIntervalSinceNow/31556926.0))
        self.ageDP.text = String(ageNum)

//        lastDP.text = tappedProfile["LastN"] as? String
        statusDP.text = tappedProfile["Status"] as? String

        let moodTXT = tappedProfile["Mood"] as? String
        moodDP.text = moodTXT
        emojiDP.image = UIImage(named: moodTXT!)


        let imageFile = tappedProfile["Picture"] as! PFFileObject
        let imageURL = imageFile.url!
        let ProfileImgURL = URL(string: imageURL)!
        imgDP.af.setImage(withURL: ProfileImgURL)

        //set up button
        ChatWithMeBTN.layer.cornerRadius = 20
        ChatWithMeBTN.layer.borderWidth = 1
        ChatWithMeBTN.setTitle("Say hello to " + firstname!, for: .normal)

        //set up to display list of stories
        StoryTV.delegate = self
        StoryTV.dataSource = self
        StoryTV.reloadData()

    }
    

    
    
    
    
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

        

        //Part1: update info in current user's profile
        //a) find userA profile
        //b) add userB's objId to userA's freindlist
        //c) add the new convo to the chatlist of userA profile
        let queryA = PFQuery(className: "Profile")
        queryA.whereKey("owner", equalTo: PFUser.current() as Any)
        queryA.findObjectsInBackground { (resultArray, error) in
            if resultArray != nil{
                if resultArray!.count == 1{
                    let currentUserProfile = resultArray![0]
                    //self.currentUserProfile = resultArray![0] as PFObject
                    print("in queryA: \(currentUserProfile)")
                    
                    
                    
//                    currentUserProfile.add(self.tappedProfile["owner"] as! PFUser, forKey: "FriendList")
                    currentUserProfile.add(self.tappedProfile, forKey: "FriendList")
                    currentUserProfile.add(mutualConvo, forKey: "Chats")
                    currentUserProfile.saveInBackground()

                    mutualConvo.add(currentUserProfile,forKey: "Participants")
                    mutualConvo.add(currentUserProfile["FirstN"],forKey: "Speaker")
                    
                    
                    
                    //Part2: update info in friend's profile
                    //a) find userB profile
                    //b) add userA's objId to userB's freindlist
                    //c) add the new convo to the chatlist of userB profile
                    let queryB = PFQuery(className: "Profile")
                    queryB.whereKey("owner", equalTo: self.tappedProfile["owner"] as! PFUser)
                    queryB.findObjectsInBackground { (resultArray, error) in
                        if resultArray != nil{
                            if resultArray!.count >= 1{
                                let FriendProfile = resultArray![0] as PFObject
                                //FriendProfile.add(PFUser.current(), forKey: "FriendList")
                                FriendProfile.add(currentUserProfile, forKey:"FriendList")
                                print("in QueryB: \(currentUserProfile)")
                                
                                FriendProfile.add(mutualConvo, forKey: "Chats")
                                FriendProfile.saveInBackground()

                                mutualConvo.add(FriendProfile, forKey: "Participants")
                                mutualConvo.add(FriendProfile["FirstN"],forKey: "Speaker")
                            }
                        }else{
                            print("Error locating the profile: \(error?.localizedDescription)")
                        }
                    }
                    
                    
                    
                    

                }
            }else{
                print("Error locating the profile: \(error?.localizedDescription)")
            }
        }


        print("middle")

//        //Part2: update info in friend's profile
//        //a) find userB profile
//        //b) add userA's objId to userB's freindlist
//        //c) add the new convo to the chatlist of userB profile
//        let queryB = PFQuery(className: "Profile")
//        queryB.whereKey("owner", equalTo: tappedProfile["owner"] as! PFUser)
//        queryB.findObjectsInBackground { (resultArray, error) in
//            if resultArray != nil{
//                if resultArray!.count >= 1{
//                    let FriendProfile = resultArray![0] as PFObject
//                    //FriendProfile.add(PFUser.current(), forKey: "FriendList")
//                    FriendProfile.add(self.currentUserProfile, forKey:"FriendList")
//                    print("in QueryB: \(self.currentUserProfile)")
//
//                    FriendProfile.add(mutualConvo, forKey: "Chats")
//                    FriendProfile.saveInBackground()
//
//                    mutualConvo.add(FriendProfile, forKey: "Participants")
//                    mutualConvo.add(FriendProfile["FirstN"],forKey: "Speaker")
//                }
//            }else{
//                print("Error locating the profile: \(error?.localizedDescription)")
//            }
//        }

    }

}
