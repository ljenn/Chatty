# CHATTY

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Chatty is a Tinder Clone. It lets the user sign up and log in, giving them access to a feed of user profiles. The user can then interact with the profile to chat with them.

### App Evaluation

- **Category:** Lifestyle / Social Networking

- **Mobile:** iOS

- **Story:** The story is compelling! There is demand in finding friends. Loneliness is a increasing problem in younger generations, so a mobile app that connects people effectively would be extremely valuable. Friends and peers will likely think it's another dating app, but that also indicates that there is demand for the service.

- **Market:** Social networking category is a multi-billion dollar industry in the United States, though it is not unique. The target market of 33 million people (age 18-30) without close friends in the United States, and that is the potential user base. If effective, this app would provide a huge value to people searching for connections. 

- **Habit:** With a user-friendly interface, we want to design a feature that allows a user to update their activity, and this would also encourage other users to keep coming back to check out what local users are up to. Average users would check a few times a day whenever they are triggered by boredom, negative feelings, or curiosity. Users can create content as they customize and update their profiles. 

- **Scope:** The app would include features needed for common social app.  The vision of the final product is similar to a Tinder clone, and the app will heavily rely on communication with the backend database. Completing the app should be manageable. A simple version would still be interesting and provide an in-demand service.  

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**

- [x] User sees app icon in home screen and styled launch screen
- [x] User can sign up to create a new account
- [x] User can log in
- [x] User can view and scroll through a list of profiles of active users
- [x] User can chat with other users
- [x] User can interact with cell (profile listed) to start a conversation. Conversation will be added to their active conversations list
- [x] User can view a list of active conversations
- [x] User can tap a conversation (cell) to chat with other users

**Optional Nice-to-have Stories**

- [ ] User can filter profiles by status
- [ ] User can search conversation by names
- [ ] User can pause their own profile from being listed in the main feed

### 2. Screen Archetypes

* Login Screen
   * User can login with username and password
* Signup Screen
   * User can sign up for a new account
* Home Screen
    * User can view and scroll through a list of profiles of active users
* List of Conversation Screen
    * User can see a list of conversations they participate in
* Chat Room Screen
    * User can see the chat history of the conversation
*  Account Screen
    * User can see his or her profile information
* Edit Screen
    * User can update his or her profile
   

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Profile feed - Tableview that lists out user profiles
* Conversation list - Tableview that lists out active conversations
* Edit profile - User can edit their own profile

**Flow Navigation** (Screen to Screen)

* Conversation list
   * Individual 1-on-1 user chat
       * Click on user profile to see user profile details
* Profile feed (truncated)
   * Click to view full profile details

## Wireframes
<img src="https://i.imgur.com/Vvl6lAC.jpg" width=400>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]

### Models

#### Profile

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
| createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   | owner        | Pointer to User| profile owner |
   | Picture         | File     | profile picture |
   | Status | String   | user status |
   | Stories    | Array (of String)   | stories |
   | LastN     | String | last name |
   | FirstN     | String | first name |
   | Chats    | Array (of Conversation)   | list of conversations user is in |
   | FriendList    | Array (of Profile)   | list of user's friends |
   
   #### Conversation

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
| createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   | ListOfMessages    | Array (of Message)   | messages belongs to the conversation|
   | Partipants    | Array (of Profile)   | users participating in the conversation |
   
   #### Message

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
| createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   | Sender        | Pointer to User| sender of the message |
   | MsgText     | String | text content of the message |
 
   
   #### User

   | Property      | Type     | Description |
   | ------------- | -------- | ------------|
   | objectId      | String   | unique id for the user post (default field) |
| createdAt     | DateTime | date when post is created (default field) |
   | updatedAt     | DateTime | date when post is last updated (default field) |
   | username     | String | username |
   | password     | String | password |
   | email     | String | email |

### Networking
#### List of network requests by screen
   - Home Feed Screen
      - (Read/GET) Query all user profiles if user does not already ahve a conversation started with user
         ```swift
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
         ```
      - (Create/POST) Create a conversation with the user
      - (Scroll) Mark & deprioritize user profile as "seen" by user
   - Self Profile Screen
      - (Read/GET) Query logged in user object
      - (Update/PUT) Update user profile image
      - (Update/PUT) Update user profile details
   - Converstaion Screen
      - (Delete) Delete existing conversation
   - Individual Chat Screen
      - (Create/POST) Create a chat mesage in the 1-on-1 user chat


### REAME GIF
### Part III walkthrough
<img src='https://github.com/Freebee2day/Chatty/blob/main/Chatty_III.gif' title='Full Video Walkthrough' width='' alt='Video Walkthrough' />

### Part II walkthrough
<img src='https://github.com/Freebee2day/Chatty/blob/main/Chatty_II.gif' title='Full Video Walkthrough' width='' alt='Video Walkthrough' />

### Part I walkthrough
<img src='https://github.com/Freebee2day/Chatty/blob/main/Chatty_I.gif' title='Full Video Walkthrough' width='' alt='Video Walkthrough' />
