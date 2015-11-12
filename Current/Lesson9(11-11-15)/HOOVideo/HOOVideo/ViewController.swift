//
//  ViewController.swift
//  HOOVideo
//
//  Created by Alex Ramey on 11/11/15.
//  Copyright © 2015 Alex Ramey. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var web_view : UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let youtube_url = NSURL(string: "https://www.youtube.com/embed/t7wdh9hXlbI")
        let request = NSURLRequest(URL: youtube_url!)
        self.web_view.loadRequest(request)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

