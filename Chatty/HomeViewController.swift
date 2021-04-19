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


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var ProfileCollection = [PFObject]()
    
    @IBOutlet weak var HomeTV: UITableView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeTV.delegate = self
        HomeTV.dataSource = self
        HomeTV.reloadData()
        
        self.HomeTV.rowHeight = 300
        // Do any additional setup after loading the view.
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
        return ProfileCollection.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        //holding one single specific profile in collection
        let singleProfile = ProfileCollection[indexPath.row]
        
        //creating a new cell to hold the profile
        let myCell = HomeTV.dequeueReusableCell(withIdentifier: "HomeCellTableView") as! HomeCellTableView
        
        myCell.statusHomeCell.text = singleProfile["Status"] as? String
        myCell.firstNHomeCell.text = singleProfile["FirstN"] as? String
        
        let imageFile = singleProfile["Picture"] as! PFFileObject
        let imgURL = imageFile.url!
        let profileURL = URL(string: imgURL)!
        myCell.imgHomeCell.af.setImage(withURL: profileURL)
        
        
        let arrayOfStory = singleProfile["Stories"] as! [String]
        if arrayOfStory.count >= 1{
            myCell.storyHomeCell.text = arrayOfStory[0]
        }
        
        return myCell
    }
    
    
    
    
    //filling the "ProfileCollection" with data fetched from Back4App whenever view appears
    override func viewDidAppear(_ animated: Bool) {
        
        let query = PFQuery(className: "Profile")
        query.includeKey("owner")
        query.whereKey("owner", notEqualTo: PFUser.current() as Any)
        query.limit = 20
        query.findObjectsInBackground { (arrayOfProfile, error) in
            if arrayOfProfile != nil{
                print("gotten result from database")
                //initiating ProfileCollection!!
                self.ProfileCollection = arrayOfProfile!
                self.HomeTV.reloadData()
            }else{
                print("Error getting result from database: \(error?.localizedDescription)")
            }
        }
        
    }
    

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //for navigating to detail screen after a specific cell is tapped on

        let tappedCell = sender as! UITableViewCell
        let index =  HomeTV.indexPath(for: tappedCell)!

        let selectedProfile = ProfileCollection[index.row]
        let ProfileDetailVC = segue.destination as! DetailProfileViewController

        //now saved the profile of the selected cell to the detail screen
        ProfileDetailVC.tappedProfile = selectedProfile

    }
    
    
    

}
