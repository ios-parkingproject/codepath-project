# Application Name

ParkingApp

# Team members

- Yangyu Shu
- Huanjia Liang

# Overview

### App Description
Allows UCI students to have a better parking experience by keep tracking of available parking spaces. 

### App Evaluation

- Category: Life tool/Convenient tool
- Mobile: Mobile is essential for the instant logging of student behavior. Students use the app to see which parking spots are available and to release their occupied spot in Map view. 
- Story: There are multiple available parking spots for users to view. Users park their cars on those spots and hit reserve button on the app to mark the spots occupied. After they are done using those spots, they hit the release button to make tht spots mark available again. In this case users can intuitively know which parking spots are available and they don't need to drive around to find parking spots.
- Market: Any school district company could utilize this app to regulate parking. 
- Habit: Depending on the timing, the users could open the app multiple times per day and create content in this app.
- Scope: First we will make the app be available to mark down each spots' information and update those info to users, then perhaps we will have another option called "leaving". What this do is those people who are about to drive away and leave their parking spot, they mark their spots' status as "about to leave", and set a counter. In this way, for those people who are about to go to the parking lot can know which spots will be available for them in a certain amount of time.


# Product Spec

### 1. User Stories

1. User can sign in
2. User can sign up
3. User can occupy an avaible spot 
4. User can release a spot
5. User can look for avaible spots

Optional Nice-to-have Stories

1. User can add map location to their spots
2. User can receive notifications once there are availble spots

### 2. app screens list
1. SignIn Screen
  User can sign in
2. SignUp Screen
  User can create a new account
3. Stream
  User can view a feed of available spots
4. Reservation
  User can reserve an avaible spots
5. Release
  User can release their occupied spots
6. Search
  User can look for other available spots

### 3. Navigation


List all your screens from above. Under each screen, list the screens you can navigate to from that screen.

Tab Navigation(Tab to Screen)
- SignIn
- SignUp
- Reserve Spots
- Release Spots

Flow Navigation(Screen to Screen)
- SignIn -> Parking Spots Information View Controller
- SignUP -> Parking Spots Information View Controller



# Wireframes
https://github.com/ios-parkingproject/codepath-project/blob/master/Edited.png


# Schema

## Models

###Post
Property    Type                    Description
username    String                  A string that represent the username for signning in
password    String                  A string that represent the password for signning in
user        PFUser object           A PFUser object that contains user's username and password
posts       Array of PFObject       An array that stores all those parking spots

# Networking
- Heroku API
  - SignIn Code:
  ```swift
        @IBAction func onSignIn(_ sender: Any) {
          let username = usernameField.text!
          let password = passwordField.text!

          PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
              if user != nil{
                  self.performSegue(withIdentifier: "loginSegue", sender: nil)
              }
              else{
                  print("Error.")
              }
          }
      }
  ```
  - SignUp Code:
  '''swift
      @IBAction func onSignUP(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }else{
                print("Error.")
            }
        }
    }
 '''
    
 - Get parking spot information code:
 '''swift
     override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let query=PFQuery(className: "parkingSpot")
        query.limit = 10
        query.findObjectsInBackground { (posts, error) in
            if posts != nil{
                self.posts = posts!
                self.tableView.reloadData()
            }
            else{
                print("did not find it")
            }
        }
    }
  '''
  - Set Release and update parking spot information to database:
  '''swift
       @IBAction func onRelease(_ sender: Any) {
        if(reserverd){
            selectedPost["availability"]=true
            selectedPost.saveInBackground { (success, error) in
                if (success) {
                    self.setReserved(false)
                } else {
                    print("release failed")
                }
            }
        }
        
    }
 '''
 - Set Reserve and update parking spot information to database:
 '''swift
    @IBAction func onReserve(_ sender: Any) {
        if(!reserverd){
            selectedPost["availability"]=false
            selectedPost.saveInBackground { (success, error) in
                if (success) {
                    self.setReserved(true)
                } else {
                    print("reserve failed")
                }
            }
            
        }
    }
   '''
   
   # GIF Walkthrough
   ### Sign Up
   <img src="https://github.com/ios-parkingproject/codepath-project/blob/master/Sign%20Up.gif" width=250><br>
   
   ### Sign In
   <img src="https://github.com/ios-parkingproject/codepath-project/blob/master/Sign%20In.gif" width=250><br>
   
   ### Reserve Spot
   <img src="https://github.com/ios-parkingproject/codepath-project/blob/master/Reserve.gif" width=250><br>
   
   ### Release Spot
   <img src="https://github.com/ios-parkingproject/codepath-project/blob/master/Release.gif" width=250><br>
   
   ### Check Spot Status as Another Client
   <img src="https://github.com/ios-parkingproject/codepath-project/blob/master/Check_as_ano_client.gif" width=250><br>
