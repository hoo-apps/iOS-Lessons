//
//  HOOPerson.swift
//  NameGame
//
//  Created by Alex Ramey on 9/13/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit
import Parse

class HOOPerson: NSObject {
    var name: String = ""
    var funFact: String = ""
    var imageKey: String = ""
    var personID : String = ""
    var image_file : PFFile?
    
    init(name: String?, funFact: String?, imageKey: String?, personID: String?, image_file: PFFile?)
    {
        self.name = name ?? "No Name"
        self.funFact = funFact ?? "No Fun Fact"
        self.imageKey = imageKey ?? ""
        self.personID = personID ?? ""
        self.image_file = image_file ?? nil
    }
    
    func getID()->String{
        return self.personID
    }
    
    func getName()->String{
        return self.name
    }
    
    func getFunFact()->String{
        return self.funFact
    }
    
    func getImage()->PFFile?{
        
        return image_file
        
        /*
        if (image != nil)
        {
            return image
        }
        else
        {
            return UIImage(named: "DefaultPicture")
        }
        */
    }
}
