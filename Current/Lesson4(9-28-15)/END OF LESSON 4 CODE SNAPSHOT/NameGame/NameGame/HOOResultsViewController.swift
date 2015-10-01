//
//  HOOResultsViewController.swift
//  NameGame
//
//  Created by Alex Ramey on 9/13/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOOResultsViewController: UIViewController {
    
    var correct:Bool = false
    var correctPerson:HOOPerson?
    
    @IBOutlet weak var name: UILabel?
    @IBOutlet weak var funFact: UILabel?
    @IBOutlet weak var picture: UIImageView?
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.picture?.image = correctPerson?.getImage()
        self.name?.text = correctPerson?.getName()
        self.funFact?.text = correctPerson?.getFunFact()
        
        self.view.backgroundColor = self.correct ? UIColor.greenColor() : UIColor.redColor()
    }
    
    override func viewDidLoad() {
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setPerson(person: HOOPerson, isCorrect: Bool)
    {
        self.correct = isCorrect
        self.correctPerson = person
    }
}
