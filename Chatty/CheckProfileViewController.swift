//
//  CheckProfileViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 5/26/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import AlamofireImage

class CheckProfileViewController: UIViewController {
    
    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var moodTXT: UILabel!
    @IBOutlet weak var moodIMG: UIImageView!
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    var storiesArray = [Story]()
    var profileID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        storyCollectionView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //fetch the current user's profile and display on the user's profile page.
        
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        
        query.whereKey("objectId", equalTo: profileID)
        query.findObjectsInBackground { (ArrayOfProfiles, error) in
            if ArrayOfProfiles != nil{
                let myProfile = ArrayOfProfiles![0]
                self.labelFirst.text = myProfile["FirstN"] as? String
                self.labelStatus.text = myProfile["Status"] as? String
                
                let fetchedDate = myProfile["Birthday"] as? Date
                let ageNum = abs(Int(fetchedDate!.timeIntervalSinceNow/31556926.0))
                self.ageLabel.text = String(ageNum)
              
                let myMoodName = myProfile["Mood"] as? String
                self.moodTXT.text = myMoodName
                self.moodIMG.image = UIImage(named: myMoodName!)
                

                let imageFile = myProfile["Picture"] as! PFFileObject
                let imageURL = imageFile.url!
                let ProfileImgURL = URL(string: imageURL)!
                self.imgProfile.af.setImage(withURL: ProfileImgURL)
                
                
                //fetch story data from database

                var myStoryList = [String]()
                var myPromptList = [String]()
                
                if myProfile["Story1"] != nil && myProfile["Story1"] as! String != "" {
                    myStoryList.append(myProfile["Story1"] as! String)
                    myPromptList.append(myProfile["Prompt1"] as! String)
                }
                
                if myProfile["Story2"] != nil && myProfile["Story2"] as! String != "" {
                    myStoryList.append(myProfile["Story2"] as! String)
                    myPromptList.append(myProfile["Prompt2"] as! String)
                }
                
                if myProfile["Story3"] != nil && myProfile["Story3"] as! String != "" {
                    myStoryList.append(myProfile["Story3"] as! String)
                    myPromptList.append(myProfile["Prompt3"] as! String)
                }
                
                //pass in two lists for stories and prompt.
                self.storiesArray = Story.getedStories(promptList: myPromptList, storyList: myStoryList)
                
                
            }else{
                print("Error fetching profile: \(error?.localizedDescription)")
            }
            self.storyCollectionView.reloadData()
        }
    }
    

}

extension CheckProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(storiesArray.count)
        return storiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CheckProfileCollectionViewCell", for: indexPath) as! CheckProfileCollectionViewCell
        let story = storiesArray[indexPath.item]
        
        cell.story = story
        
        return cell
    }
    
}
