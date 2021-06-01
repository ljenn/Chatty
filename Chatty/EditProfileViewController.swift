//
//  EditProfileViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/14/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import Toast_Swift
import DropDown


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    
    @IBOutlet weak var editImage: UIImageView!
    
    @IBOutlet weak var editStory: UITextField!
    
    @IBOutlet weak var menuView: UIView!
    
    @IBOutlet weak var moodLabel: UILabel!
    
    @IBOutlet weak var emoji: UIImageView!
    
    @IBOutlet weak var status: UITextField!
    
    
    var edStoriesArray = [EditStory]()
    
    var savingStoryAtIndex: Int!
    
    
    @IBOutlet weak var editCollectionView: UICollectionView!
    
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
        
        editCollectionView.dataSource = self
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(didTapMenu))
        gesture.numberOfTouchesRequired = 1
        gesture.numberOfTapsRequired = 1
        menuView.addGestureRecognizer(gesture)
        moodMenu.anchorView = menuView
        menuView.layer.borderWidth = 1
        menuView.layer.borderColor = UIColor.systemTeal.cgColor
        
        moodMenu.selectionAction = {index, title in
            //print("index \(index) and \(title)")
            self.moodLabel.text = title
            self.emoji.image = UIImage(named: title)
        }
        

       
    }
    
    @objc func didTapMenu(){
        moodMenu.show()
    }
    
    override func viewDidAppear(_ animated: Bool) {
                
        //fetch the user's profile info and use as default value in each field
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        query.whereKey("owner", equalTo: PFUser.current() as Any)
        query.findObjectsInBackground { (ArrayOfProfiles, error) in
            if ArrayOfProfiles != nil{
                let myProfile = ArrayOfProfiles![0]
                self.status.text = myProfile["Status"] as? String
                
                let emojiText = myProfile["Mood"] as? String
                self.moodLabel.text = emojiText
                self.emoji.image = UIImage(named: emojiText!)
                
                let imageFile = myProfile["Picture"] as! PFFileObject
                let imageURL = imageFile.url!
                let ProfileImgURL = URL(string: imageURL)!
                self.editImage.af.setImage(withURL: ProfileImgURL)
                
                //get data for collection view
                //more efficient way?
                var pmp1: String
                if myProfile["Prompt1"] != nil{
                    pmp1 = myProfile["Prompt1"] as! String
                }else{
                    pmp1 = "Select Prompt1"
                }
                
                var pmp2: String
                if myProfile["Prompt2"] != nil{
                    pmp2 = myProfile["Prompt2"] as! String
                }else{
                    pmp2 = "Select Prompt2"
                }
                
                var pmp3: String
                if myProfile["Prompt3"] != nil{
                    pmp3 = myProfile["Prompt3"] as! String
                }else{
                    pmp3 = "Select Prompt3"
                }
                
                var sty1: String
                if myProfile["Story1"] != nil{
                    sty1 = myProfile["Story1"] as! String
                }else{
                    sty1 = "Enter Story 1"
                }
                
                var sty2: String
                if myProfile["Story2"] != nil{
                    sty2 = myProfile["Story2"] as! String
                }else{
                    sty2 = "Enter Story 2"
                }
                
                var sty3: String
                if myProfile["Story3"] != nil{
                    sty3 = myProfile["Story3"] as! String
                }else{
                    sty3 = "Enter Story 3"
                }
                
                self.edStoriesArray = EditStory.getedStories(prompt1: pmp1, prompt2: pmp2, prompt3: pmp3, story1: sty1, story2: sty2, story3: sty3)
                
            }else{
                print("Error fetching profile: \(error?.localizedDescription)")
            }
            self.editCollectionView.reloadData()
        }
    }
    

    @IBAction func btnSave(_ sender: Any) {
        
        //once user hit submit button, use the data text entries and save changes to database
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        query.whereKey("owner", equalTo: PFUser.current() as Any)

        query.findObjectsInBackground { (ProfileArray, error) in
            if ProfileArray != nil{
                let profileToUpdate = ProfileArray![0]
                
                
//                profileToUpdate["FirstN"] = self.editFirst.text
//                profileToUpdate["LastN"] = self.editLast.text
                profileToUpdate["Status"] = self.status.text
                profileToUpdate["Mood"] = self.moodLabel.text
                
                let myImageData = self.editImage.image?.pngData()
                let myImageFile = PFFileObject(name: "Picture.png", data: myImageData!)
                profileToUpdate["Picture"] = myImageFile
                
                profileToUpdate.saveInBackground()
                self.view.makeToast("Profile Updated!")
                self.dismiss(animated: true, completion: nil)
                
                
            }else{
                print("Error fetching profile: \(error?.localizedDescription)")
            }
        }
        
    }
    
    
    
    
    //the following fxns are for picking pictures and displaying new picture on the image view.
    
    @IBAction func btnSelectNewPicture(_ sender: Any) {
        //a gesture listener btn that allow user to pick new image upon tapping.
        let myCameraPicker = UIImagePickerController()
        myCameraPicker.delegate = self
        myCameraPicker.allowsEditing = true

        if UIImagePickerController.isSourceTypeAvailable(.camera){
            myCameraPicker.sourceType = .camera
            //check if there a camera feature in phone
        }else{
            myCameraPicker.sourceType = .photoLibrary
            //if not, pick a photo from gallery
        }

        present(myCameraPicker, animated: true, completion: nil)
    }
    
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        //display the newly selected image in image view.
        
        let myimg = info[.editedImage] as! UIImage
        
        //resize image
        let size = CGSize(width: 300, height: 300)
        
        //let scaled_myimg = myimg.af.imageScaled(to: size)
        let scaled_myimg = myimg.af.imageAspectScaled(toFill: size)
        
        editImage.image = scaled_myimg
        
        dismiss(animated: true, completion: nil)    //leaving the gallery selector && going back to the post composing view
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


extension EditProfileViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return edStoriesArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "EditProfileCollectionViewCell", for: indexPath) as! EditProfileCollectionViewCell
        let edStory = edStoriesArray[indexPath.item]
        
        cell.edStory = edStory
        cell.myIndex = indexPath.item
        cell.parentVC = self
        
        
        return cell
    }

    
    
}
