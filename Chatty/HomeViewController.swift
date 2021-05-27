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


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ProfileCollection = [PFObject]()
    
    var filteredProfileCollection = [PFObject]()
    
    var myProfile = PFObject(className: "Profile")
    
    var mylist = [PFObject]()
    
    @IBOutlet weak var myfilterBTN: UIButton!
    
    @IBAction func tappedMyMenu(_ sender: Any) {
        moodMenu.show()
    }
    
    
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
    
    @IBOutlet weak var HomeTV: UITableView!
    

    

    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        HomeTV.delegate = self
        HomeTV.dataSource = self
        HomeTV.reloadData()
        
        
        moodMenu.anchorView = myfilterBTN
        
        
        viewDidAppear(true)
        
        self.HomeTV.rowHeight = 300
        
        
        
    }
    
    
    
    
    //filling the "ProfileCollection" with data fetched from Back4App whenever view appears
    override func viewDidAppear(_ animated: Bool) {
        
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
                //VV for user using filter
                //(everytime screen reload, filter is gone => default to "All")
                
                
                
                self.moodMenu.selectionAction = {index, title in
                    //need to filter out by mood

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
        
    }
    
    

    
    func filterOutFriend(){
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

        
        
        let arrayOfStory = singleProfile["Stories"] as! [String]
        if arrayOfStory.count >= 1{
            myCell.storyHomeCell.text = arrayOfStory[0]
        }
        
        self.HomeTV.deselectRow(at: indexPath, animated: true)
        
        return myCell
    }
    
    

    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //for navigating to detail screen after a specific cell is tapped on

        let tappedCell = sender as! UITableViewCell
        let index =  HomeTV.indexPath(for: tappedCell)!

        let selectedProfile = filteredProfileCollection[index.row]
        let ProfileDetailVC = segue.destination as! DetailProfileViewController

        //now saved the profile of the selected cell to the detail screen
        ProfileDetailVC.tappedProfile = selectedProfile

    }
    
    
    

}
