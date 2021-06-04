//
//  ConvoViewController.swift
//  Chatty
//
//  Created by Phoebe Zhong  on 4/16/21.
//  Copyright © 2021 Phoebe Zhong . All rights reserved.
//




import UIKit
import MessageKit
import InputBarAccessoryView
import Parse
import AlamofireImage



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

class ConvoViewController: MessagesViewController, MessagesDataSource, MessagesLayoutDelegate, MessagesDisplayDelegate,InputBarAccessoryViewDelegate{
    
    
    
    
    //(MessagesViewController is a parent class class offered by MsgKit)
    
    let myMessageBar = InputBarAccessoryView()
    
    
    
    //previously: create convo and pass in objectID.
    var belongingConvoID = String()
    var belongingConvo = PFObject(className: "Conversation")
    
    //for navigating to the detail profile. 
    var AnotherUserProfileID = ""
    
    var msgListOfPFObject = [PFObject]()
    var msgListOfProcessedMESSAGE = [MessageType]()
    
    
    //senderID doesn't matter (for MESSAGE object, but matter for PFObject in database)
    //might need to fix profile picture and display name later.
    let currentUser = Sender(senderId: "1357", displayName: "Jason")
    let AnotherUser = Sender(senderId: "2468", displayName: "Jona")
    
    
//    func configureAvatarView(_ avatarView: AvatarView, for message: MessageType, at indexPath: IndexPath, in messagesCollectionView: MessagesCollectionView) {
//        
//        let imageFile = singleProfile["Picture"] as! PFFileObject
//        let imgURL = imageFile.url!
//        let profileURL = URL(string: imgURL)!
//        let myIMG(Image)
//        
//        avatarView.set(avatar: Avatar(image: <#T##UIImage?#>, initials: "Jason"))
//    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        //hide senders' profile image...
        if let layout = messagesCollectionView.collectionViewLayout as? MessagesCollectionViewFlowLayout{
            layout.textMessageSizeCalculator.outgoingAvatarSize = .zero
            layout.textMessageSizeCalculator.incomingAvatarSize = .zero
        }

        
        //clear out the msg collection (so no duplicate)
        msgListOfProcessedMESSAGE.removeAll()
        
        //need to load Message Object (from back 4 app) and create Message (based on MessageKit model)
        //aka initiate the Message History
        let query = PFQuery(className: "Conversation")
        
        query.includeKeys(["ListOfMessages","Sender"])
        
        //print(belongingConvoID)
        query.whereKey("objectId", equalTo: belongingConvoID)
        
        query.findObjectsInBackground { (ArrayOfConversations, error) in
            if ArrayOfConversations != nil{
                //returned an array of result but in reality only expecting one matching conversation
                let tempConvo = ArrayOfConversations![0]

                //store the PFObjects of msg from database in local varable
                if tempConvo["ListOfMessages"] != nil{
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
                }
                
                //TODO: sent message doesn't auto reload
                self.messagesCollectionView.reloadData()
                
                
                // findObjectsInBackground fxn has a different thread, need to call viewDidLoad (on another thread) to show data. 
                self.viewDidLoad()
                
                //scrolling to the most recent message:
                self.messagesCollectionView.scrollToLastItem()
                
                

            }else{
                print("Error fetching profile: \(error?.localizedDescription)")
            }
        }
    }
    

    

    override func viewDidLoad() {
        //let timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(update), userInfo: nil, repeats: true)
        

        
        super.viewDidLoad()

        
        messagesCollectionView.reloadData()
        messagesCollectionView.messagesDataSource = self
        messagesCollectionView.messagesLayoutDelegate = self
        messagesCollectionView.messagesDisplayDelegate = self
        
        
        messagesCollectionView.keyboardDismissMode = .interactive
        myMessageBar.delegate = self
        
        let rightBTN = UIBarButtonItem(title: "Profile", style: .done, target: self, action: #selector(didTapTitle))
        self.navigationItem.rightBarButtonItem  = rightBTN
        
        
    }
    @objc func didTapTitle(){
        
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "checkid") as! CheckProfileViewController
        resultViewController.profileID = AnotherUserProfileID
        self.navigationController?.pushViewController(resultViewController, animated: true)
        
    }
    
//    @objc func update(){
//        viewDidAppear(true)
//        print("updating!")
//    }
    
    
    
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


    func inputBar(_ inputBar: InputBarAccessoryView, didPressSendButtonWith text: String) {
        
        
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
                            
                            //show sent msg immediately
                            //pull data from database everytime a msg is sent.
                            self.viewDidAppear(true)
                            
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
        //messagesCollectionView.reloadData()
    
    }


}
