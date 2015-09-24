//
//  HOOPlayer.swift
//  HOONameGame
//
//  Created by Alex Ramey on 9/16/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit

/*  
    NSCoding is a protocol. By conforming to it,
    HOOPlayer is compatible with functions that 
    save data to the phone 
*/

class HOOPlayer: NSObject, NSCoding {
    var playerID: Int = 0
    var peopleSeen: [Int] = []
    var numCorrectAnswers: Int = 0
    var numIncorrectAnswers: Int = 0
    
    /* Keys that we used to save data to the phone */
    let KEY_PLAYER_ID = "KEY_PLAYER_ID"
    let KEY_LIST_NAMES_SEEN = "KEY_NAMES_SEEN"
    let KEY_NUM_CORRECT = "KEY_NUM_CORRECT"
    let KEY_NUM_INCORRECT = "KEY_NUM_INCORRECT"
    
    init(playerID:Int)
    {
        // First time we ever create a player, this initializer will be called.
        self.playerID = playerID
        super.init()
    }
    
    func recordPersonSeen(person: HOOPerson){
        self.peopleSeen.append(person.getID())
    }
    
    func getPeopleSeen()->[Int]{
        return self.peopleSeen
    }
    
    func recordCorrectAnswer(){
        self.numCorrectAnswers++
    }
    
    func recordIncorrectAnswer(){
        self.numIncorrectAnswers++
    }
    
    func getCorrectIncorrect()->(Int,Int){
        return (self.numCorrectAnswers, self.numIncorrectAnswers)
    }
    
    func getPercentageCorrect()->Float{
        if (numCorrectAnswers + numIncorrectAnswers == 0)
        {
            return 0.0
        }
        else
        {
            return 100.0 * Float(numCorrectAnswers) / Float(numCorrectAnswers + numIncorrectAnswers)
        }
    }
    
    func getPlayerID() -> Int
    {
        return self.playerID
    }
    
    func reset()
    {
        self.peopleSeen = []
        self.numCorrectAnswers = 0
        self.numIncorrectAnswers = 0
    }
    
    // MARK: NSCoding
    
    // Taking it out of the archive
    // Note: This is a designated initializer
    required init(coder decoder: NSCoder)
    {
        // 1. Set our properties
        self.playerID = decoder.decodeIntegerForKey(KEY_PLAYER_ID)
        self.peopleSeen = decoder.decodeObjectForKey(KEY_LIST_NAMES_SEEN) as! [Int]
        self.numCorrectAnswers = decoder.decodeIntegerForKey(KEY_NUM_CORRECT)
        self.numIncorrectAnswers = decoder.decodeIntegerForKey(KEY_NUM_INCORRECT)
        
        // 2. Delegate Up!
        super.init()
    }
    
    // Putting it into the archive
    func encodeWithCoder(aCoder: NSCoder)
    {
        aCoder.encodeInteger(self.playerID, forKey: KEY_PLAYER_ID)
        aCoder.encodeObject(self.peopleSeen, forKey: KEY_LIST_NAMES_SEEN)
        aCoder.encodeInteger(self.numCorrectAnswers, forKey: KEY_NUM_CORRECT)
        aCoder.encodeInteger(self.numIncorrectAnswers, forKey: KEY_NUM_INCORRECT)
    }
}
