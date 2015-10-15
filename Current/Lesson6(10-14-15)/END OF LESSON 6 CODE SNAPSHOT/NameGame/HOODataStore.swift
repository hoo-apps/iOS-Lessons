//
//  HOODataStore.swift
//  NameGame
//
//  Created by Alex Ramey on 9/13/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit
import Parse

class HOODataStore: NSObject{
    // Singleton Instance
    static let sharedInstance = HOODataStore()
    
    var people: [HOOPerson] = []
    var players: [HOOPlayer] = []
    
    let PLAYERS_DEFAULTS_KEY = "PLAYERS_DEFAULTS_KEY"
    
    override init(){
        //1. Make sure all of your properties have been assigned a value
        
        // Get our Players (Local user(s) of the app)
        let arrayOfPlayersData = NSUserDefaults.standardUserDefaults().objectForKey(PLAYERS_DEFAULTS_KEY) as? NSData
        if (arrayOfPlayersData != nil)
        {
            players = NSKeyedUnarchiver.unarchiveObjectWithData(arrayOfPlayersData!) as? [HOOPlayer] ?? []
        }
        else
        {
            players = []
        }
        
        if (players.count == 0)
        {
            // First time the game has been played
            let player = HOOPlayer(playerID: 1)
            players.append(player)
        }
        
        /*
        Uncomment to test
        for person in people
        {
            println(person.getName())
        }
        */
        
        //2. Delegate Up (Call superclass designated or convenience initializer)
        super.init()
        
        //3. Optionally overwrite values of inherited properties
        // We don't do this
    }
    
    func loadInPeopleFromParseWithCompletion(closure: (NSError?) -> Void )
    {
        let query = PFQuery(className:"Person")
        
        /* In Swift, closures are enclosed in {} and are defined by function type  parms -> return_type 
            followed by the 'in' keyword which seperates closure header from its body */
        query.findObjectsInBackgroundWithBlock { (objects:[PFObject]?, error:NSError?) -> Void in
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved data.")
                // Do something with the found objects
                if let objects = objects {
                    for object in objects {
                        print(object)
                        self.people.append(HOOPerson(name: object["name"] as? String, funFact: object["funFact"] as? String, imageKey: object["compID"] as? String, personID: object.objectId, image_file:object["picture"] as? PFFile))
                    }
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
                self.people = []
            }
            closure(error);
        }
    }
    
    func isDataLoaded()->Bool
    {
        return people.count > 0;
    }
    /*
    func loadInPeopleFromLocalFile()
    {
        // Load in People that populate the Game
        if let path = NSBundle.mainBundle().pathForResource("jsonData", ofType: "json")
        {
            if let jsonData = try? NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe)
            {
                if let decodedJson = (try? NSJSONSerialization.JSONObjectWithData(jsonData, options: [])) as? Dictionary<String, Array<Dictionary<String, AnyObject>>>
                {
                    if let peopleDictionaries:[Dictionary<String, AnyObject>] = decodedJson["data"]
                    {
                        for dict in peopleDictionaries
                        {
                            people.append(HOOPerson(name: dict["name"] as? String, funFact: dict["funFact"] as? String, imageKey: dict["compID"] as? String, personID: dict["id"] as? String));
                        }
                    }
                }
                else
                {
                    print("jsonError")
                }
            }
        }
    }
    */
    func getFirstPlayer()->HOOPlayer
    {
        return self.players[0]
    }
    
    func clearPeople()
    {
        self.people = []
    }
    
    func getListOfPeopleContaining(numItems numItems : Int,  excludedName: String) -> Array<HOOPerson> {
        
        var allPeopleMinuesExcludedPerson: [HOOPerson] = []
        
        for p in self.people
        {
            if (p.getName() != excludedName)
            {
                allPeopleMinuesExcludedPerson.append(p)
            }
        }
        
        if (allPeopleMinuesExcludedPerson.count <= numItems)
        {
            return allPeopleMinuesExcludedPerson
        }
        else
        {
            var result: [HOOPerson] = [];
            
            while (result.count < numItems)
            {
                let randomIndex = arc4random_uniform((UInt32)(allPeopleMinuesExcludedPerson.count));
                let randomPerson = allPeopleMinuesExcludedPerson[(Int)(randomIndex)]
                var isPersonNotYetInResult = true;
                
                for p in result
                {
                    if (p.getName() == randomPerson.getName())
                    {
                        isPersonNotYetInResult = false;
                    }
                }
                
                if (isPersonNotYetInResult)
                {
                    result.append(randomPerson);
                }
            }
            
            return result
        }
    }
    
    func getListOfPeopleContaining(numItems numItems: Int, unseenByUser user:HOOPlayer) -> Array<HOOPerson> {
        
        if (self.people.count - user.getPeopleSeen().count <= numItems)
        {
            var result: [HOOPerson] = []
            
            for p in self.people
            {
                if (!user.getPeopleSeen().contains(p.getID()))
                {
                    result.append(p);
                }
            }
            
            return result // all the people the user has yet to see
        }
        else
        {
            var allUnseenPeople: [HOOPerson] = []
            
            for p in self.people
            {
                if (!user.getPeopleSeen().contains(p.getID()))
                {
                    allUnseenPeople.append(p);
                }
            }
            
            var result: [HOOPerson] = [];
            
            while (result.count < numItems)
            {
                let randomIndex = arc4random_uniform((UInt32)(allUnseenPeople.count));
                let randomPerson = allUnseenPeople[(Int)(randomIndex)]
                var isPersonNotYetInResult = true;
                
                for p in result
                {
                    if p.getID() == randomPerson.getID()
                    {
                        isPersonNotYetInResult = false;
                    }
                }
                
                if (isPersonNotYetInResult)
                {
                    result.append(randomPerson);
                }
            }
            
            return result
        }
    }
    
    func saveGameData(){
        let arrayOfPlayersData = NSKeyedArchiver.archivedDataWithRootObject(players)
        NSUserDefaults.standardUserDefaults().setObject(arrayOfPlayersData, forKey: PLAYERS_DEFAULTS_KEY)
    }
}
