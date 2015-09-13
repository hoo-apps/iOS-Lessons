//
//  HOOPerson.swift
//  NameGame
//
//  Created by Alex Ramey on 9/13/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOOPerson: NSObject {
    var name: String = ""
    var funFact: String = ""
    var imageKey: String = ""
    var personID : Int = -1
    
    init(name: String?, funFact: String?, imageKey: String?, personID: Int?)
    {
        self.name = name ?? "No Name";
        self.funFact = funFact ?? "No Fun Fact"
        self.imageKey = imageKey ?? ""
        self.personID = personID ?? -1;
    }
    
    func getID()->Int{
        return self.personID
    }
    
    func getName()->String{
        return self.name
    }
    
    func getFunFact()->String{
        return self.funFact
    }
    
    func getImage()->UIImage?{
        
        var image = UIImage(named:imageKey)
        
        if (image != nil)
        {
            return image
        }
        else
        {
            return UIImage(named: "DefaultPicture")
        }
    }
}
