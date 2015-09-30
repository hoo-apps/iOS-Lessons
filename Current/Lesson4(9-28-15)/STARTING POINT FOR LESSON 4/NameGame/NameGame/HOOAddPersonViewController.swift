//
//  HOOAddPersonViewController.swift
//  NameGame
//
//  Created by Alex Ramey on 9/30/15.
//  Copyright © 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOOAddPersonViewController: UIViewController {

    @IBOutlet weak var picture: UIImageView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func addPicSelected(sender: UIButton)
    {
        
    }
    
    @IBAction func doneSelected(sender: UIButton)
    {
        self.dismissViewControllerAnimated(true, completion: nil)
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
