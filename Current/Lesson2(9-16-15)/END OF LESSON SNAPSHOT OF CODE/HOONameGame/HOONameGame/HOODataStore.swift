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
        var arrayOfPlayersData = NSUserDefaults.standardUserDefaults().objectForKey(PLAYERS_DEFAULTS_KEY) as? NSData
        
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
            var player = HOOPlayer(playerID: 1)
            players.append(player)
        }
        
        // Load in the People that populate the Game
        
        // 2. Delegate Up (Call the superclass designation initializer or convenience)
        super.init()
        
        // 3. Optionally overwrite values of inherited properties
    }
}
