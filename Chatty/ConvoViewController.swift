//
//  ConvoViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/16/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//


//Problems to fix:
//limit to only recent messages OR anchord to the end of convo. 
//auto refresh to display new message!!



import UIKit
import MessageKit
import MessageInputBar
import Parse



//no need to create another class, just use User's info
struct Sender: SenderType {
    //(SenderType is an interface from MsgKit)
    
    var senderId: String
    
    var displayName: String
    
    
}

//need to create this class in Parse
struct Message: MessageType {
    var sender: SenderType
    
    var messageId: String
    
    var sentDate: Date
    
    var kind: MessageKind
    
}

class ConvoViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate,MessageInputBarDelegate{
    //(MessagesViewController is a parent class class offered by MsgKit)
    
    let myMessageBar = MessageInputBar()
    
    
    //TODO: should be sent over by the calling item.
    //previously: create convo and pass in objectID.
    var belongingConvoID = String()
    var belongingConvo = PFObject(className: "Conversation")
    
    var msgListOfPFObject = [PFObject]()
    var msgListOfProcessedMESSAGE = [MessageType]()
    var test = [String]()
    
    
    //senderID doesn't matter (for MESSAGE object, but matter for PFObject in database)
    //might need to fix profile picture and display name later.
    let currentUser = Sender(senderId: "1357", displayName: "Jason")
    let AnotherUser = Sender(senderId: "2468", displayName: "Jona")
    
    override func viewDidAppear(_ animated: Bool) {
        //need to load Message Object (from back 4 app) and create Message (based on MessageKit model)
        //aka initiate the Message History

        let query = PFQuery(className: "Conversation")
        
        query.includeKeys(["ListOfMessages","Sender"])
        
        print(belongingConvoID)
        query.whereKey("objectId", equalTo: belongingConvoID)
        
        //query.limit = 3
        
        query.findObjectsInBackground { (ArrayOfConversations, error) in
            if ArrayOfConversations != nil{
                //returned an array of result but in reality only expecting one matching conversation
                let tempConvo = ArrayOfConversations![0]

                //store the PFObjects of msg from database in local varable
                self.msgListOfPFObject = tempConvo["ListOfMessages"] as! [PFObject]
                
                for i in 0...self.msgListOfPFObject.count-1{
                    let singleMsg = self.msgListOfPFObject[i]
                    
                    
                    //"MsgText" is a created class so need to access like dictionary
                    let txt = singleMsg["MsgText"] as! String
                    
                    //"objectId" and "createdAt" are native attriute in Parse, so accessed with . as member attribute
                    let myId = singleMsg.objectId!
                    let mydate = singleMsg.createdAt!
                    
                    let messageSender = singleMsg["Sender"] as! PFUser
                    
                    if messageSender.objectId == PFUser.current()?.objectId{
                        self.msgListOfProcessedMESSAGE.append(Message(sender: self.currentUser,
                                                      messageId: myId,
                                                      sentDate: mydate,
                                                      kind: .text(txt)))
                    } else{
                        self.msgListOfProcessedMESSAGE.append(Message(sender: self.AnotherUser,
                                                      messageId: myId,
                                                      sentDate: mydate,
                                                      kind: .text(txt)))
                    }

                }
                self.messagesCollectionView.reloadData()
                // findObjectsInBackground fxn has a different thread, need to call viewDidLoad (on another thread) to show data. 
                self.viewDidLoad()
                
                

            }else{
                print("Error fetching profile: \(error?.localizedDescription)")
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        
        messagesCollectionView.reloadData()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        
        messagesCollectionView.keyboardDismissMode = .interactive
        myMessageBar.delegate = self
        
        
    }
    
    
    
    
    func currentSender() -> SenderType {
        return currentUser
    }
    
    func messageForItem(at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) -> MessageType {
        return msgListOfProcessedMESSAGE[indexPath.section]
    }
    
    func numberOfSections(in messagesCollectionView: MessagesCollectionView) -> Int {
        return msgListOfProcessedMESSAGE.count
    }
    
    
    override var inputAccessoryView: UIView?{
        return myMessageBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return true
    }

    
    func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        
        //Step1.1: create a PFO Message object
        let freshMessage = PFObject(className: "Message")
        freshMessage["MsgText"] = text
        freshMessage["Sender"] = PFUser.current()!
        
        //Step1.2 save the PFO Message in Back4app database
        //Step1.2 a)find the belonging conversation object
        let query = PFQuery(className: "Conversation")
        query.includeKeys(["ListOfMessages","Sender"])
        query.whereKey("objectId", equalTo: belongingConvoID)
        query.findObjectsInBackground { (arrayOfResult, error) in
            
            if arrayOfResult != nil {
                if arrayOfResult!.count >= 1{
                    self.belongingConvo = arrayOfResult![0]
        //Step1.2 b)add message to the conversation and save
                    self.belongingConvo.add(freshMessage,forKey: "ListOfMessages")
                    self.belongingConvo.saveInBackground { (success, error) in
                        if success{
                            print("Your message is saved")
                        }else{
                            print("Error saving message: \(error?.localizedDescription)")
                        }
                    }
                }
    
            } else{
                print("Error finding converation to save message to: \(error?.localizedDescription)")
            }
            
            
        }
        
        
        //Step2: clear the text after sending
        myMessageBar.inputTextView.text = nil
        
        
        //Step3: reload data so new message shows up
        //not working :(
        messagesCollectionView.reloadData()
    
    }
  
    



}
