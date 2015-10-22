//
//  ViewController.swift
//  HOOSwiftTableView
//
//  Created by Alex Ramey on 10/21/15.
//  Copyright © 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOOTableViewController : UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var table_view: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table_view?.backgroundColor = UIColor.purpleColor()
        self.table_view?.dataSource = self
        self.table_view?.delegate = self
        table_view?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell_identifier")
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /* UITableViewDataSource Protocol Methods */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        
        if (indexPath.section == 0)
        {
            cell.backgroundColor = UIColor.redColor()
            cell.textLabel?.text = "Hello World"
        }
        else if (indexPath.section == 1)
        {
            if (indexPath.row == 0)
            {
                cell.backgroundColor = UIColor.blueColor()
                cell.textLabel?.text = "\u{1F4A9}"
            }
            else if (indexPath.row == 1)
            {
                cell.backgroundColor = UIColor.greenColor()
            }
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section + 1;
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2;
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if (section == 0)
        {
            return "First Section"
        }
        else
        {
            return "Second Section"
        }
    }
    
    /* UITableViewDelegate */
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        if (indexPath.section == 1 && indexPath.row == 0)
        {
            self.performSegueWithIdentifier("ShowYellow", sender: self)
        }
    }

}

