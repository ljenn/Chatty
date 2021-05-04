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

- [ ] User sees app icon in home screen and styled launch screen
- [ ] User can sign up to create a new account
- [ ] User can log in
- [ ] User can view and scroll through a list of profiles of active users
- [ ] User can chat with other users
- [ ] User can interact with cell (profile listed) to start a conversation. Conversation will be added to their active conversations list
- [ ] User can view a list of active conversations
- [ ] User can tap a conversation (cell) to chat with other users

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
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
