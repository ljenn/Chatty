//
//  MakeProfileViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/12/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse
import AlamofireImage
import DropDown

class MakeProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    
    @IBOutlet weak var tfFirst: UITextField!
    @IBOutlet weak var imgProfilePic: UIImageView!
    @IBOutlet weak var tfAge: UITextField!
    let myDatePicker = UIDatePicker()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        showFormattedDatePicker()
        }
    
    

    func showFormattedDatePicker(){
        myDatePicker.datePickerMode =  .date
        tfAge.inputView = myDatePicker
        
        let myToolBar = UIToolbar()
        myToolBar.sizeToFit()
        
        let doneBTN = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: #selector(donePicking))
        let space = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        
        let cancelBTN = UIBarButtonItem(title: "Cancel", style: UIBarButtonItem.Style.plain, target: self, action: #selector(cancelPicking))
        
        
        
        myToolBar.setItems([cancelBTN,space,doneBTN], animated: true)
        tfAge.inputAccessoryView = myToolBar
        tfAge.inputView = myDatePicker
        
        
    }

    let storyPromptMenu: DropDown = {
        let storyPromptMenu = DropDown()
        storyPromptMenu.dataSource = [
            "tell me your best story",
        ]
        return storyPromptMenu
    }()
    
    @objc func donePicking(){
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        tfAge.text = formatter.string(from: myDatePicker.date)
        self.view.endEditing(true)
        
        
        //calculated age. 
        print(abs(Int(myDatePicker.date.timeIntervalSinceNow/31556926.0)))
    }
    
    @objc func cancelPicking(){
        self.view.endEditing(true)
        
    }
    
    
    
    
    
    
    
    @IBAction func ContinueI(_ sender: Any) {
        
        performSegue(withIdentifier: "toProfileTwoSegue", sender: self)
        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let secondVC = storyboard.instantiateViewController(identifier: "CenterNavigationController") //storyboardID
//
//        secondVC.modalPresentationStyle = .fullScreen
//        secondVC.modalTransitionStyle = .crossDissolve
//
//        self.present(secondVC, animated: true, completion: nil)
        
    }
    
    
    //the following fxns are for picking pictures and displaying new picture on the image view.
    @IBAction func btnSelectPicture(_ sender: Any) {
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
        
        imgProfilePic.image = scaled_myimg
        
        dismiss(animated: true, completion: nil)    //leaving the gallery selector && going back to the post composing view
    }
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
           if (segue.identifier == "toProfileTwoSegue") {
               if let nextViewController = segue.destination as? MakeProfileTwoViewController {
                
                //save first name info to the next screen
                nextViewController.myName = tfFirst.text
                
                //save DOB
                nextViewController.myDOB = myDatePicker.date
                
                
                //save profile img info
                let myImageData = imgProfilePic.image?.pngData()
                let myImageFile = PFFileObject(name: "Picture.png", data: myImageData!)
                nextViewController.myImage = myImageFile
                
                }
           }
   }
   

    
    
    
    
    
    
}

