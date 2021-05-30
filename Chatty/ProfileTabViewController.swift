//
//  ProfileTabViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/13/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import AlamofireImage
import Parse

//extension UIImageView {
//    func applyBlurEffect() {
//        let blurEffect = UIBlurEffect(style: .light)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        addSubview(blurEffectView)
//    }
//}

class ProfileTabViewController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var labelFirst: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
//    @IBOutlet weak var labelStory: UILabel!
    @IBOutlet weak var labelStatus: UILabel!
    @IBOutlet weak var moodIMG: UIImageView!
    @IBOutlet weak var moodTXT: UILabel!
    @IBOutlet weak var storyCollectionView: UICollectionView!
    
    var storiesArray = Story.getStories()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        self.view.backgroundColor = UIColor(patternImage: imgProfile.image!)
//        
//        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        blurEffectView.frame = view.bounds
//        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        self.view.insertSubview(blurEffectView, at: 0)
        
        
//        let sampleImageView = UIImageView(frame: CGRectMake(0, 200, 300, 325))
//        let sampleImage:UIImage = UIImage(named: "ic_120x120")!
//        sampleImageView.image =  sampleImage
//
//        //Convert To Blur Image Here
//        sampleImageView.makeBlurImage(sampleImageView)
//
//        self.view.addSubview(sampleImageView)
        
        super.viewDidLoad()
        storyCollectionView.dataSource = self

    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        //fetch the current user's profile and display on the user's profile page.
        
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        
        query.whereKey("owner", equalTo: PFUser.current() as Any)
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
            }else{
                print("Error fetching profile: \(error?.localizedDescription)")
            }
        }
    }
    

}

extension ProfileTabViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return storiesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SelfProfileStoryCollectionViewCell", for: indexPath) as! SelfProfileStoryCollectionViewCell
        let story = storiesArray[indexPath.item]
        
        cell.story = story
        
        return cell
    }
    
}
