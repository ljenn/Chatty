//
//  ChatViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/16/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//

import UIKit
import Parse


//generic table view show a list of conversations

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    

    @IBOutlet weak var ChatTV: UITableView!
    
    
    //an array of conversation.
    var ChatCollection = [PFObject]()
    var myProfileID = ""
    
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        let query = PFQuery(className: "Profile")
        query.includeKeys(["owner","Chats","Participants","Conversation","Profile"])
        
        query.whereKey("owner", equalTo: PFUser.current() as Any)
        
        query.findObjectsInBackground { (arrayOfProfile, error) in
            if arrayOfProfile != nil {
                let tempProfile = arrayOfProfile![0]
                self.myProfileID = tempProfile.objectId!
                if tempProfile["Chats"] != nil{
                    self.ChatCollection = tempProfile["Chats"] as! [PFObject]
                }
                
                self.viewDidLoad()
            
            }else{
                print("Error fetching conversation: \(error?.localizedDescription)")
            }
        }
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        ChatTV.dataSource = self
        ChatTV.delegate = self
        ChatTV.reloadData()
        
        //check if still needed if we have our own cell blueprint
        ChatTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return ChatCollection.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: update later
        //have our customed cell blueprint
        //now use generic cell
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        
        let oneConvo = ChatCollection[indexPath.row]
        //record participants in the conversation
        let participants = oneConvo["Participants"] as! [PFObject]
    
        var friendID = ""
        var friendName = ""
        
        //find out the friend's profileID (which is the one not matching current user's ID)
        for talker in participants{
            if talker.objectId != myProfileID{
                friendID = talker.objectId!
            }
        }
        
        //find the friend's profile by id
        //set the conversation title to friend's first name.
        let query = PFQuery(className: "Profile")
        query.whereKey("objectId", equalTo: friendID)
        query.findObjectsInBackground { (arr, error) in
            if arr != nil{
                let oneFriend = arr![0] as PFObject
                friendName = oneFriend["FirstN"] as! String
                myCell.textLabel?.text = friendName
            }
        }

        
        //show an arrow at the end of each cell
        myCell.accessoryType = .disclosureIndicator
        
        return myCell
    }
    
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //if cell is selected, deselect:
        ChatTV.deselectRow(at: indexPath, animated: true)
        
        //navigate to specific conversation
        let vc = ConvoViewController()
        let selectedConvo = ChatCollection[indexPath.row]
        vc.title = ChatTV.cellForRow(at: indexPath)?.textLabel?.text
        //vc.title = "Conversation"

        //send the id of the selected conversation to the convo (later to retrieve messages belonging to the convo)
        vc.belongingConvoID = selectedConvo.objectId!
        navigationController?.pushViewController(vc, animated: true)
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
