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

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate{
    

    @IBOutlet weak var mySearchBar: UISearchBar!
    
    @IBOutlet weak var ChatTV: UITableView!
    
    
    //an array of conversation.
    var ChatCollection = [PFObject]()
    var filteredChatCollection = [PFObject]()
    var myProfileID = ""
    var friendProfileID = ""
    //var friendProfile: PFObject!
    
    
    
    
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
                
                //where to put?!
                self.filteredChatCollection = self.ChatCollection
                
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
        mySearchBar.delegate = self
        
        
        ChatTV.keyboardDismissMode = .interactive
                
        ChatTV.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        //check if still needed if we have our own cell blueprint
        ChatTV.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //clear content
        filteredChatCollection = []


        if searchText == "" {
            //display all available chat if not searching
            filteredChatCollection = ChatCollection
        } else{
            //check if matches firstname
            for chat in ChatCollection{
                let participants = chat["Speaker"] as! [String]
                for person in participants{
                    if person.lowercased().contains(searchText.lowercased()){
                        filteredChatCollection.append(chat)
                    }
                }
            }
        }
        self.ChatTV.reloadData()
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredChatCollection.count
        //return ChatCollection.count
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //TODO: update later
        //have our customed cell blueprint
        //now use generic cell
        let myCell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        
        
        //let oneConvo = ChatCollection[indexPath.row]
        let oneConvo = filteredChatCollection[indexPath.row]
        
        //record participants in the conversation
        let participants = oneConvo["Participants"] as! [PFObject]
    
        
        var friendName = ""
        
        //find out the friend's profileID (which is the one not matching current user's ID)
        for talker in participants{
            if talker.objectId != myProfileID{
                friendProfileID = talker.objectId!
            }
        }
        
        //find the friend's profile by id
        //set the conversation title to friend's first name.
        let query = PFQuery(className: "Profile")
        query.whereKey("objectId", equalTo: friendProfileID)
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
        
        
        let theParticipants = selectedConvo["Participants"] as! [PFObject]
        //find out the friend's profileID (which is the one not matching current user's ID)
        for talker in theParticipants{
            if talker.objectId != myProfileID{
                vc.AnotherUserProfileID = talker.objectId!
            }
        }
        

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
