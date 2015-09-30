//
//  HOOStatsViewController.swift
//  NameGame
//
//  Created by Alex Ramey on 9/13/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOOStatsViewController: UIViewController {

    @IBOutlet weak var percentageLabel: UILabel?
    @IBOutlet weak var correctIncorrectLabel: UILabel?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        let player = HOODataStore.sharedInstance.getFirstPlayer()
        self.percentageLabel?.text = "\(player.getPercentageCorrect())% Correct"
        self.correctIncorrectLabel?.text = "Correct: \(player.getCorrectIncorrect().0) Incorrect: \(player.getCorrectIncorrect().1)"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func resetPressed(sender: UIButton)
    {
        HOODataStore.sharedInstance.getFirstPlayer().reset()
        HOODataStore.sharedInstance.clearPeople()
        if let navController = self.tabBarController?.viewControllers?.first as? UINavigationController
        {
            if let gameController = navController.viewControllers[0] as? HOOGameViewController
            {
                gameController.reset()
            }
        }
        self.viewWillAppear(true)
    }
}
