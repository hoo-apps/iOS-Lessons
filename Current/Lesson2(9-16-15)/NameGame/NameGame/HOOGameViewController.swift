//
//  ViewController.swift
//  NameGame
//
//  Created by Alex Ramey on 9/9/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOOGameViewController: UIViewController {

    @IBOutlet weak var option1: UIButton?
    @IBOutlet weak var option2: UIButton?
    @IBOutlet weak var option3: UIButton?
    @IBOutlet weak var option4: UIButton?
    @IBOutlet weak var picture: UIImageView?
    
    var correctPerson: HOOPerson?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        var unseenPersonList = HOODataStore.sharedInstance.getListOfPeopleContaining(numItems: 1, unseenByUser: HOODataStore.sharedInstance.getFirstPlayer())
        
        if (unseenPersonList.count == 0)
        {
            var alert = UIAlertView(title: "Alert", message: "You've seen everybody", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            return
        }
        
        self.correctPerson = unseenPersonList[0]
        self.picture?.image = self.correctPerson?.getImage()
        
        var buttons = [option1,option2,option3,option4]
        var option:UInt32 = arc4random_uniform(4);
        var correctButton = buttons.removeAtIndex((Int)(option))
        correctButton?.setTitle(unseenPersonList[0].getName(), forState: UIControlState.Normal)
        
        var randomPeople = HOODataStore.sharedInstance.getListOfPeopleContaining(numItems: buttons.count, excludedName: unseenPersonList[0].getName())
        
        for (index, rndPerson) in enumerate(randomPeople) {
            buttons[index]?.setTitle(rndPerson.getName(), forState: UIControlState.Normal)
        }
    }
    
    @IBAction func selectionMade(sender: UIButton)
    {
        var player = HOODataStore.sharedInstance.getFirstPlayer()
        if (sender.titleForState(UIControlState.Normal) == self.correctPerson!.getName())
        {
            player.recordCorrectAnswer()
        }
        else
        {
            player.recordIncorrectAnswer()
        }
        
        player.recordPersonSeen(self.correctPerson!)
        
        self.performSegueWithIdentifier("GameToResults", sender: sender)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    // Get the new view controller using segue.destinationViewController.
    // Pass the selected object to the new view controller.
        var vc = segue.destinationViewController as! HOOResultsViewController
        var btnSender: UIButton? = sender as? UIButton
        vc.setPerson(self.correctPerson!, isCorrect: (btnSender?.titleForState(UIControlState.Normal) == self.correctPerson!.getName()))
        
        // reset state
        self.correctPerson = nil;
        self.picture?.image = nil
        option1?.setTitle("", forState: UIControlState.Normal)
        option2?.setTitle("", forState: UIControlState.Normal)
        option3?.setTitle("", forState: UIControlState.Normal)
        option4?.setTitle("", forState: UIControlState.Normal)
    }


}

