//
//  HOODataStore.swift
//  NameGame
//
//  Created by Alex Ramey on 9/13/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOODataStore: NSObject{
    // Singleton Instance
    static let sharedInstance = HOODataStore()
    
    var people: [HOOPerson] = []
    var players: [HOOPlayer] = []
    
    let PLAYERS_DEFAULTS_KEY = "PLAYERS_DEFAULTS_KEY"
    
    override init(){
        //1. Make sure all of your properties have been assigned a value
        
        // Get our Players (Local user(s) of the app)
        var arrayOfPlayersData = NSUserDefaults.standardUserDefaults().objectForKey(PLAYERS_DEFAULTS_KEY) as? NSData
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
            var player = HOOPlayer(playerID: 1)
            players.append(player)
        }
        
        // Load in People that populate the Game
        if let path = NSBundle.mainBundle().pathForResource("jsonData", ofType: "json")
        {
            if let jsonData = NSData(contentsOfFile: path, options: .DataReadingMappedIfSafe, error: nil)
            {
                var jsonError: NSError?
                let decodedJson = NSJSONSerialization.JSONObjectWithData(jsonData, options: nil, error: &jsonError) as! Dictionary<String, Array<Dictionary<String, AnyObject>>>
                
                if (jsonError == nil)
                {
                    if let peopleDictionaries:[Dictionary<String, AnyObject>] = decodedJson["data"]
                    {
                        for dict in peopleDictionaries
                        {
                            people.append(HOOPerson(name: dict["name"] as? String, funFact: dict["funFact"] as? String, imageKey: dict["compID"] as? String, personID: dict["id"] as? Int));
                        }
                    }
                }
                else
                {
                    print(jsonError!)
                }
            }
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
    }
    
    func getFirstPlayer()->HOOPlayer
    {
        return self.players[0]
    }
    
    func getListOfPeopleContaining(#numItems : Int,  excludedName: String) -> Array<HOOPerson> {
        
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
                var randomIndex = arc4random_uniform((UInt32)(allPeopleMinuesExcludedPerson.count));
                var randomPerson = allPeopleMinuesExcludedPerson[(Int)(randomIndex)]
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
    
    func getListOfPeopleContaining(#numItems: Int, unseenByUser user:HOOPlayer) -> Array<HOOPerson> {
        
        if (self.people.count - user.getPeopleSeen().count <= numItems)
        {
            var result: [HOOPerson] = []
            
            for p in self.people
            {
                if (!contains(user.getPeopleSeen(), p.getID()))
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
                if (!contains(user.getPeopleSeen(), p.getID()))
                {
                    allUnseenPeople.append(p);
                }
            }
            
            var result: [HOOPerson] = [];
            
            while (result.count < numItems)
            {
                var randomIndex = arc4random_uniform((UInt32)(allUnseenPeople.count));
                var randomPerson = allUnseenPeople[(Int)(randomIndex)]
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
        var arrayOfPlayersData = NSKeyedArchiver.archivedDataWithRootObject(players)
        NSUserDefaults.standardUserDefaults().setObject(arrayOfPlayersData, forKey: PLAYERS_DEFAULTS_KEY)
    }
}
