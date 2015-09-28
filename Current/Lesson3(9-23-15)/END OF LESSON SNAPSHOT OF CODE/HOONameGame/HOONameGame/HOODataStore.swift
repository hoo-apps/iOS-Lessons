//
//  HOODataStore.swift
//  HOONameGame
//
//  Created by Alex Ramey on 9/16/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOODataStore: NSObject{
    
    // Singleton Instance
    static let sharedInstance = HOODataStore()
   
    // This happens before init
    var people: [HOOPerson] = []
    var players: [HOOPlayer] = []
    
    // This key is used to access NSUserDefaults, which is the location
    // where our app will save data to the phone
    let PLAYERS_DEFAULTS_KEY = "PLAYERS_DEFAULTS_KEY"
    
    // designated initializer
    override init(){
        // 1. Make sure all your properties have been assigned a value
        
        // Get our Players (Local user(s)) from NSUserDefaults
        // ? means it could be NULL or Nil or 0
        let arrayOfPlayersData = NSUserDefaults.standardUserDefaults().objectForKey(PLAYERS_DEFAULTS_KEY) as? NSData
        
        if (arrayOfPlayersData != nil)
        {
            players = NSKeyedUnarchiver.unarchiveObjectWithData(arrayOfPlayersData!) as? [HOOPlayer] ?? []
        }
        else
        {
            // NSUserDefaults Fetch Failed
            players = []
        }
        
        if (players.count == 0)
        {
            // First time game is being played; Or defaults fetch failed.
            let player = HOOPlayer(playerID: 1)
            players.append(player)
        }
        
        // Load in the People that populate the Game
        let path = NSBundle.mainBundle().pathForResource("NameGame", ofType: "json")
        if (path != nil)
        {
            if let jsonData = try? NSData(contentsOfFile: path!, options: .DataReadingMappedIfSafe)
            {
                if let decodedJson = try? NSJSONSerialization.JSONObjectWithData(jsonData, options: []) as! Dictionary<String, Array<Dictionary<String, AnyObject>>>
                {
                    if let peopleDictionaries:[Dictionary<String, AnyObject>] = decodedJson["data"]
                    {
                        for dict in peopleDictionaries
                        {
                            people.append(HOOPerson(name: dict["name"] as? String, funFact: dict["funFact"] as? String, imageKey: dict["compID"] as? String, personID: dict["id"] as? Int))
                        }
                    }
                }
            }
        }
        
        // 2. Delegate Up (Call the superclass designation initializer or convenience)
        super.init()
        
        // 3. Optionally overwrite values of inherited properties
    }
    
    func getFirstPlayer()->HOOPlayer
    {
        return self.players[0]
    }
    
    /* this function is called by the view controller to get the answer choices.
        numItems is how many choices to get, excluded name is a name that may not appear
        in the results
    */
    func getListOfPeopleContaining(numItems numItems : Int, excludedName:String) -> [HOOPerson]
    {
        var allPeopleMinusExcludedPerson : [HOOPerson] = []
        
        for p in self.people
        {
            if (p.getName() != excludedName)
            {
                allPeopleMinusExcludedPerson.append(p)
            }
        }
        
        if (allPeopleMinusExcludedPerson.count <= numItems)
        {
            return allPeopleMinusExcludedPerson
        }
        else
        {
            var result:[HOOPerson] = []
            
            while (result.count < numItems)
            {
                let randomIndex = arc4random_uniform((UInt32)(allPeopleMinusExcludedPerson.count))
                let randomPerson = allPeopleMinusExcludedPerson[(Int)(randomIndex)]
                var isPersonNotYetInResult = true
                
                for p in result
                {
                    if (p.getName() == randomPerson.getName())
                    {
                        isPersonNotYetInResult = false
                    }
                }
                
                if (isPersonNotYetInResult)
                {
                    result.append(randomPerson)
                }
            }
            
            return result
        }
    }
    
    func getListOfPeopleContaining(numItems numItems: Int, unseenByUser user:HOOPlayer) -> [HOOPerson]
    {
        if (self.people.count - user.getPeopleSeen().count <= numItems)
        {
            var result: [HOOPerson] = []
            
            for p in self.people
            {
                if (!user.getPeopleSeen().contains(p.getID()))
                {
                    result.append(p)
                }
            }
            
            return result // all the people the user has yet to see
        }
        else
        {
            var allUnseenPeople:[HOOPerson] = []
            
            for p in self.people
            {
                if (!user.getPeopleSeen().contains(p.getID()))
                {
                    allUnseenPeople.append(p)
                }
            }
            
            var result: [HOOPerson] = []
            
            while (result.count < numItems)
            {
                let randomIndex = arc4random_uniform((UInt32)(allUnseenPeople.count))
                let randomPerson = allUnseenPeople[(Int)(randomIndex)]
                var isPersonNotYetInResult = true
                
                for p in result
                {
                    if p.getID() == randomPerson.getID()
                    {
                        isPersonNotYetInResult = false
                    }
                }
                
                if (isPersonNotYetInResult)
                {
                    result.append(randomPerson)
                }
            }
            
            return result
        }
    }
    
    func saveGameData()
    {
        let arrayOfPlayersData = NSKeyedArchiver.archivedDataWithRootObject(players)
        NSUserDefaults.standardUserDefaults().setObject(arrayOfPlayersData, forKey: PLAYERS_DEFAULTS_KEY)
    }
}
