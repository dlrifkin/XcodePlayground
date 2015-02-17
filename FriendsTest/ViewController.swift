//
//  ViewController.swift
//  FriendsTest
//
//  Created by Apprentice on 2/16/15.
//  Copyright (c) 2015 Apprentice. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource  {
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var txtIncompleteFieldsMessage: UILabel!
    
    @IBAction func signUp(sender: AnyObject) {
        var usrEntered = username.text
        var pwdEntered = password.text
        var emlEntered = email.text
//        var friendz = PFRelation()
        
        func userSignUp(){
            
            var user = PFUser()
            user.username = usrEntered
            user.password = pwdEntered
            user.email = emlEntered
//            user.friendz = PFRelation()
            
            user.signUpInBackgroundWithBlock {
                (succeded: Bool!, error: NSError!) -> Void in
                if error == nil {
                    //Hooray!
                    self.txtIncompleteFieldsMessage.text = "User Signed Up";
                } else {
                    //Show the errorString
                }
            }
        }
        
        if usrEntered != "" && pwdEntered != "" && emlEntered != "" {
            userSignUp()
        } else {
            self.txtIncompleteFieldsMessage.text = "All Fields Required"
        }

    }
    
    @IBAction func sendFriendRequest(sender: AnyObject) {
        
        var user = PFUser.currentUser()
        var friendRequest = PFObject(className: "FriendRequest")
        
        friendRequest["fromUser"] = user.objectId
        friendRequest["toUser"] = "1nF2Lc4nDt"
        friendRequest["status"] = "Pending"
        
        friendRequest.saveInBackgroundWithBlock {
            (success: Bool, error: NSError!) -> Void in
            if (success) {
                
                // Display message that friend request was sent
                println("YES")
            } else {
                // Display message that friend request was NOT sent
                println("NOPE")
            }
        }
    }
    
    
    @IBOutlet weak var friendsRequestTable: UITableView!
    
    var users = ["hello"]
//
//    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        populateFriendRequests()
        
        let cell = UITableViewCell(style: .Subtitle, reuseIdentifier: nil)
//        cell.textLabel?.text = users[indexPath.row]
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("HHEY from \(users[indexPath.row])")
    }
    
    @IBOutlet weak var displayUsername: UILabel!
    

    func populateFriendRequests(){
        //give us a parse object - array that contains all friend request objects with "toUser" = "currentUser"
        var query = PFQuery(className: "FriendRequest")

        var users = [AnyObject]()
        
        query.whereKey("toUser", equalTo: "1nF2Lc4nDt")
        
        var x = query.findObjects()
        
        func each<T>(items: Array<T>, fn: T -> ()){
            for item in items {
                fn(item)
            }
        }
        each([1,2,3]){
            number in
            println(number)
        }
        each(["one", "two", "three"]) {
            number in
            println(number)
        }
        each(x) {
            number in
            println(number)
        }

//        query.findObjects().map({x in "\(x)ee"})
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        friendsRequestTable.dataSource = self
        friendsRequestTable.delegate = self

        populateFriendRequests()

        //        let butts = populateFriendRequests
        
        //        var blah = [AnyObject]()
        //        blah.append(PFUser())
        //        println(blah)
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    

//    
//    func populateButtons(){
//        let button = UIButton.buttonWithType(UIButtonType.System) as UIButton
//        button.frame = CGRectMake(100, 100, 100, 50)
//        button.backgroundColor = UIColor.greenColor()
//        button.setTitle("New Friend Request", forState: UIControlState.Normal)
//        button.addTarget(self, action: "statusAccepted", forControlEvents: UIControlEvents.TouchUpInside)
//        
//        self.view.addSubview(button)
//    }
    
    
    //    func handleAcceptButtonPressed(sender: UIButton) {
//        
//        //the buttons tag stores the indexPath.row of the array
//        let friendRequest: PFObject = self.friendRequestsToCurrentUser[sender.tag] as PFObject
//        
//        let fromUser: PFUser = friendRequest[FriendRequestKeyFrom] as PFUser
//        
//        //call the cloud code function that adds the current user to the user who sent the request and pass in the friendRequest id as a parameter
//        PFCloud.callFunctionInBackground("addFriendToFriendsRelation", withParameters: ["friendRequest": friendRequest.objectId]) { (object:AnyObject!, error: NSError!) -> Void in
//            
//            //add the person who sent the request as a friend of the current user
//            let friendsRelation: PFRelation = self.currentUser.relationForKey(UserKeyFriends)
//            friendsRelation.addObject(fromUser)
//            self.currentUser.saveInBackgroundWithBlock({ (succeeded: Bool, error: NSError!) -> Void in
//                
//                if succeeded {
//                    
//                    
//                    
//                } else {
//                    
//                    Utilities.handleError(error)
//                }
//            })
//        }
//        
//        
//    }

//    
    
    @IBOutlet weak var displayMe: UILabel!
    
    func convertTxt() {
        displayMe.text = "lala"
    }
    
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true;
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        username.endEditing(true)
        email.endEditing(true)
        password.endEditing(true)
    }

    

//    override func viewWillAppear(animated: Bool) {
//        var user = PFUser()
//        user.objectId = "pq0ZcLixQm"
//        PFCloud.callFunctionInBackground("hello", withParameters: ["objectId": user.objectId], new FunctionCallback() {
//            public void done(Object object, ParseException e) {
//                if (e == null) {
//                    processResponse(object);
//                } else {
//                    handleError();
//                }
//            })
//        // Do any additional setup after loading the view, typically from a nib.
//        
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

