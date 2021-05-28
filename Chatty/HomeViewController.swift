//
//  HomeViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/12/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import Toast_Swift
import DropDown
import InputBarAccessoryView


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,InputBarAccessoryViewDelegate{

    
    
    let myMessageBar = InputBarAccessoryView()
    
    var showMsgBar = false
    
    var ProfileCollection = [PFObject]()
    
    var filteredProfileCollection = [PFObject]()
    
    var myProfile = PFObject(className: "Profile")
    
    var selectedProfile = PFObject(className: "Profile")
    
    var mylist = [PFObject]()
    
    @IBOutlet weak var myfilterBTN: UIButton!
    
    @IBAction func tappedMyMenu(_ sender: Any) {
        moodMenu.show()
    }
    
    @IBOutlet weak var HomeTV: UITableView!
    

    let moodMenu: DropDown = {
        let moodMenu = DropDown()
        moodMenu.dataSource = [
            "All",
            "Studying",
            "Partying",
            "Exercising",
            "Eating",
        ]
        return moodMenu
    }()

    

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("in did load")
        
        //print("called by did load")
        //viewDidAppear(true)
        
//        myMessageBar.delegate = self
//        HomeTV.keyboardDismissMode = .interactive
//
//        let myCenter = NotificationCenter.default
//        myCenter.addObserver(self, selector: #selector(hideMyKeyBoard(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
//
//
//        HomeTV.delegate = self
//        HomeTV.dataSource = self
//        HomeTV.reloadData()
//
//        moodMenu.anchorView = myfilterBTN
//
//
//
//        self.HomeTV.rowHeight = 300
        
        loadHomeTVData()
        
    }
    
    @objc func hideMyKeyBoard(note: Notification){
        myMessageBar.inputTextView.text = nil
        showMsgBar = false
        becomeFirstResponder()
    }
    
    func loadHomeTVData() {
        myMessageBar.delegate = self
        HomeTV.keyboardDismissMode = .interactive
        
        let myCenter = NotificationCenter.default
        myCenter.addObserver(self, selector: #selector(hideMyKeyBoard(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        
        HomeTV.delegate = self
        HomeTV.dataSource = self
        HomeTV.reloadData()
        
        moodMenu.anchorView = myfilterBTN
    
        self.HomeTV.rowHeight = 300
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        loadHomeTVData()
        HomeTV?.reloadData()
    }
    
    
    
    //filling the "ProfileCollection" with data fetched from Back4App whenever view appears
    override func viewDidAppear(_ animated: Bool) {
   
        
        print("in appear")
        self.myfilterBTN.setTitle("All", for: .normal)
        
        ProfileCollection.removeAll()
        filteredProfileCollection.removeAll()
        
        //fetching all profiles (except that of the current user) in database
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        query.whereKey("owner", notEqualTo: PFUser.current() as Any)
        query.limit = 20
        query.findObjectsInBackground { (arrayOfProfile, error) in
            if arrayOfProfile != nil{
                //initiating ProfileCollection!!
                self.ProfileCollection = arrayOfProfile!
                
                //filtered collection need to have data to show even if the user didn't click on filter
                self.filteredProfileCollection = self.ProfileCollection
                
                //will filter for both collections
                self.filterOutFriend()
                
                self.HomeTV.reloadData()
                

                
                
                
                //^^for user not using filter
                //vv for user using filter
                //(everytime screen reload, filter is gone => default to "All")
                
                
                
                self.moodMenu.selectionAction = {index, title in
                    //need to filter out by mood
                    self.myfilterBTN.setTitle(title, for: .normal)
                    
                    if(title == "All"){
                        
                        //still need to refresh/syn the 2 collections
                        self.viewDidAppear(true)
                    }else{
                        //clear content
                        self.filteredProfileCollection.removeAll()
                        //only select the matching items from Profile collection to filtered collection.
                        for profile in self.ProfileCollection{
                            let theMood = profile["Mood"] as! String
                            if theMood == title{
                                self.filteredProfileCollection.append(profile)
                            }
                        }
                    }

                    self.HomeTV.reloadData()
                
                }
                
                
            }else{
                print("Error getting result from database: \(error?.localizedDescription)")
            }
        }
        HomeTV.reloadData()
    

        
    }
    
    

    
    func filterOutFriend(){
        print("in friend filter")
        
        //looking up current user's profile to check friend's list.
        let friendListquery = PFQuery(className: "Profile")
        friendListquery.includeKeys(["User","owner"])
        friendListquery.whereKey("owner", equalTo: PFUser.current() as Any)
        friendListquery.findObjectsInBackground { (result, error) in
            let tempArray = result!
            self.myProfile = tempArray[0]
            
            
            if self.myProfile["FriendList"] != nil{
                 self.mylist = self.myProfile["FriendList"] as! [PFObject]
                 //not very efficient way to remove freind list from all profile
                 var k = self.filteredProfileCollection.count
                if(k >= 1){
                 for i in 0...self.mylist.count-1{
                     for j in 0...k-1{
                        if(self.mylist[i].objectId == self.filteredProfileCollection[j].objectId){
                            //filter friends lists for both collection at the same time
                            //be careful: are they always the same?
                             self.filteredProfileCollection.remove(at: j)
                             self.ProfileCollection.remove(at: j)
                             k -= 1
                             break
                         }
                    }
                    }
                }
            }

        self.HomeTV.reloadData();

        }

    }
    
    
    
    
    
    @IBAction func btnLogout(_ sender: Any) {
        
        PFUser.logOut()

        let main = UIStoryboard(name: "Main", bundle: nil)
        let LoginStoryBoard = main.instantiateViewController(identifier: "LoginStoryBoard")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else {return}

        delegate.window?.rootViewController = LoginStoryBoard
        
        delegate.window?.rootViewController?.view.makeToast("Logout Successfully!")
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredProfileCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //holding one single specific profile in collection
        let singleProfile = filteredProfileCollection[indexPath.row]
        
        
        //creating a new cell to hold the profile
        let myCell = HomeTV.dequeueReusableCell(withIdentifier: "HomeCellTableView") as! HomeCellTableView
        
        
        //PartI: setup cell for display on HomeVC
        let myMood = singleProfile["Mood"] as? String
        myCell.moodLabel.text = myMood
        myCell.emoji.image = UIImage(named: myMood!)
        
        myCell.statusHomeCell.text = singleProfile["Status"] as? String
        
        
        myCell.firstNHomeCell.text = singleProfile["FirstN"] as? String
        
        let imageFile = singleProfile["Picture"] as! PFFileObject
        let imgURL = imageFile.url!
        let profileURL = URL(string: imgURL)!
        myCell.imgHomeCell.af.setImage(withURL: profileURL)
        
        
        let fetchedDate = singleProfile["Birthday"] as? Date
        let ageNum = abs(Int(fetchedDate!.timeIntervalSinceNow/31556926.0))
        myCell.ageCell.text = String(ageNum)

        
        //MARK: work on story pagination!
        let arrayOfStory = singleProfile["Stories"] as! [String]
        if arrayOfStory.count >= 1{
            //myCell.storyHomeCell.text = arrayOfStory[0]
        }
        
        
        
        
        //PartII: pass over information in cell for chatting btn (Table View Cell)
        //need to know which profile is selected and access they keyboard appearance
        myCell.cellProfile = singleProfile
        myCell.homeVC = self
        
        return myCell
    }
    
    
    
    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
    //Step1: create convo

        //update conversation list and friend list in "my profile" and "freind's profile"
        //userA = current User   &&   userB = the new friend

        //Step 1.1 create new conversation
        let mutualConvo = PFObject(className: "Conversation")

        //Step 1.2: update info in current user's profile
        //a) find userA profile
        //b) add userB's profile to userA's freindlist
        //c) add the new convo to the chatlist of userA profile
        let queryA = PFQuery(className: "Profile")
        queryA.whereKey("owner", equalTo: PFUser.current() as Any)
        queryA.findObjectsInBackground { (resultArray, error) in
            if resultArray != nil{
                if resultArray!.count == 1{
                    let currentUserProfile = resultArray![0]
                    currentUserProfile.add(self.selectedProfile, forKey: "FriendList")
                    currentUserProfile.add(mutualConvo, forKey: "Chats")
                    currentUserProfile.saveInBackground()

                    mutualConvo.add(currentUserProfile,forKey: "Participants")
                    mutualConvo.add(currentUserProfile["FirstN"],forKey: "Speaker")
                    
                    
                    
                    //Step 1.3: update info in friend's profile
                    //a) find userB profile
                    //b) add userA's Profile to userB's freindlist
                    //c) add the new convo to the chatlist of userB profile
                    let queryB = PFQuery(className: "Profile")
                    queryB.whereKey("owner", equalTo: self.selectedProfile["owner"] as! PFUser)
                    queryB.findObjectsInBackground { (resultArray, error) in
                        if resultArray != nil{
                            if resultArray!.count >= 1{
                                let FriendProfile = resultArray![0] as PFObject
                                FriendProfile.add(currentUserProfile, forKey:"FriendList")
                                
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

        
    //Step2: Create the message and append to conversation
        //Step2.1: create a PFO Message object
            let freshMessage = PFObject(className: "Message")
            freshMessage["MsgText"] = self.myMessageBar.inputTextView.text
            freshMessage["Sender"] = PFUser.current()!
        //Step2.2 b)add message to the conversation and save
            mutualConvo.add(freshMessage,forKey: "ListOfMessages")
        
        
    //Step3: clear and dismiss message bar
        myMessageBar.inputTextView.text = nil
        showMsgBar = false
        becomeFirstResponder()
        myMessageBar.inputTextView.resignFirstResponder()
        
        
    //Step3: show notification
        view.makeToast("Message Sent!")
        
    //Step4: reload data not working!!!!
        viewDidAppear(true)
        HomeTV.reloadData()
    
    }
    
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.HomeTV.deselectRow(at: indexPath, animated: true)
    }
    
    
    override var inputAccessoryView: UIView?{
         return myMessageBar
     }
     
     override var canBecomeFirstResponder: Bool{
         return showMsgBar
     }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //for navigating to detail screen after a specific cell is tapped on

        
        //MARK: no more segue -> try chat on same pg
        //deleted segue to detail: showCellDetailSegue
        
//        let tappedCell = sender as! UITableViewCell
//        let index =  HomeTV.indexPath(for: tappedCell)!
//
//        let selectedProfile = filteredProfileCollection[index.row]
//        let ProfileDetailVC = segue.destination as! DetailProfileViewController
//
//        //now saved the profile of the selected cell to the detail screen
//        ProfileDetailVC.tappedProfile = selectedProfile

    }
    
    
    

}
