//
//  HOOAddPersonViewController.swift
//  NameGame
//
//  Created by Alex Ramey on 9/30/15.
//  Copyright © 2015 Alex Ramey. All rights reserved.
//

import UIKit
import Parse

class HOOAddPersonViewController : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    let imagePicker = UIImagePickerController()
    @IBOutlet weak var picture: UIImageView?
    @IBOutlet weak var nameInput: UITextField?
    @IBOutlet weak var funFactInput: UITextField?
    @IBOutlet weak var compIDInput: UITextField?
    
    var kboardHeight : CGFloat = 0.0
    var is_screen_shifted: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imagePicker.delegate = self
        
        // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(myNotificationMethod:) name:UIKeyboardDidShowNotification object:nil];
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardNotification:"), name: UIKeyboardDidShowNotification, object: nil)
        
        // Do any additional setup after loading the view.
    }

    func keyboardNotification(notification: NSNotification)
    {
        print("Notified!")
        if let info = notification.userInfo
        {
            if let value = info[UIKeyboardFrameBeginUserInfoKey]
            {
                if let kboardFrame = value.CGRectValue
                {
                    if (kboardHeight == 0.0)
                    {
                        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - kboardFrame.height, self.view.frame.size.width, self.view.frame.size.height)
                        kboardHeight = kboardFrame.height
                        is_screen_shifted = true
                    }
                }
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPicSelected(sender: UIButton)
    {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .Camera
        presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func doneSelected(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
        
        // Normally, you should first check that the input is valid
        // i.e. good picture, non-blank names,compid, funfact
        // check for profanity
        // if it passes, then upload. We're going to assume good input for now
        
        let hooPerson = PFObject(className:"Person")
        hooPerson["compID"] = compIDInput?.text
        hooPerson["funFact"] = funFactInput?.text
        hooPerson["name"] = nameInput?.text
        
        if let image = picture?.image
        {
            if let data = UIImagePNGRepresentation(image)
            {
                let file = PFFile(name:"picture.png", data:data)
                file.saveInBackgroundWithBlock({ (success: Bool, error: NSError?) -> Void in
                    if (success) {
                        print("Save Success!")
                        hooPerson["picture"] = file
                        hooPerson.saveInBackgroundWithBlock {
                            (success_two: Bool, error: NSError?) -> Void in
                            if (success_two) {
                                print("Save Success!")
                            } else {
                                // There was a problem, check error.description
                                print("Save Error! \(error?.description)")
                            }
                        }
                    } else {
                        // There was a problem, check error.description
                        print("Save Error! \(error?.description)")
                    }
                })
            }
            
            
        }
    }

    @IBAction func tapReceived(sender: UIGestureRecognizer)
    {
        // This is the click-away case,
        // where we also want to dismiss the keyboard
        print("Tap Received")
        if (is_screen_shifted)
        {
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + kboardHeight, self.view.frame.size.width, self.view.frame.size.height)
            is_screen_shifted = false
        }
        
        self.view.endEditing(true)
    }
    
    // MARK: - UIImagePickerControllerDelegate Methods
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            // Convert it to NSData and save it to the device in the NSDocuments directory
            // b/c in the event of low memory-warning, this image may be deallocated and you
            // lose it if it's isn't backed up
            picture?.contentMode = .ScaleAspectFit
            picture?.image = pickedImage
        }
        
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    // MARK: - UITextFieldDelegate Methods
    func textFieldDidBeginEditing(textField: UITextField)
    {
        // here we will shift the view to accomodate the keyboard . . .
        print("Text Field Did Begin Editing: \(textField.frame.origin.y)")
        if (!is_screen_shifted)
        {
            UIView.animateWithDuration(0.7, animations: { () -> Void in
                self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - self.kboardHeight, self.view.frame.size.width, self.view.frame.size.height)
            })
            is_screen_shifted = true
        }
        
    }
    
    func textFieldDidEndEditing(textField: UITextField)
    {
        // here we will shift the view back to its normal state
        print("Text Field Did End Editing: \(textField.frame.origin.y)")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        // this means the user tapped return, which is the first case
        // where we want to dismiss the keyboard
        self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + kboardHeight, self.view.frame.size.width, self.view.frame.size.height)
        is_screen_shifted = false
        self.view.endEditing(true)
        return true
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
}
