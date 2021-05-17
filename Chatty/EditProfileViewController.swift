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


class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    @IBOutlet weak var editFirst: UITextField!
    
    @IBOutlet weak var editLast: UITextField!
    
    @IBOutlet weak var editImage: UIImageView!
    
    @IBOutlet weak var editStatus: UITextField!
    
    @IBOutlet weak var editStory: UITextField!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //fetch the user's profile info and use as default value in each field
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        query.whereKey("owner", equalTo: PFUser.current() as Any)
        query.findObjectsInBackground { (ArrayOfProfiles, error) in
            if ArrayOfProfiles != nil{
                let myProfile = ArrayOfProfiles![0]
                self.editFirst.text = myProfile["FirstN"] as? String
                self.editLast.text = myProfile["LastN"] as? String
                self.editStatus.text = myProfile["Status"] as? String
                
                let imageFile = myProfile["Picture"] as! PFFileObject
                let imageURL = imageFile.url!
                let ProfileImgURL = URL(string: imageURL)!
                self.editImage.af.setImage(withURL: ProfileImgURL)
                
            }else{
                print("Error fetching profile: \(error?.localizedDescription)")
            }
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
                
                
                profileToUpdate["FirstN"] = self.editFirst.text
                profileToUpdate["LastN"] = self.editLast.text
                profileToUpdate["Status"] = self.editStatus.text
                
                let myImageData = self.editImage.image?.pngData()
                let myImageFile = PFFileObject(name: "Picture.png", data: myImageData!)
                profileToUpdate["Picture"] = myImageFile
                
                profileToUpdate.saveInBackground()
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
