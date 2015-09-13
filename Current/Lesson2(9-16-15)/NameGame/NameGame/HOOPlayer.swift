//
//  HOOPlayer.swift
//  NameGame
//
//  Created by Alex Ramey on 9/13/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

import UIKit

class HOOPlayer: NSObject, NSCoding
{
    var playerID: Int = 0
    var peopleSeen: [Int] = []
    var numCorrectAnswers: Int = 0
    var numIncorrectAnswers: Int = 0
    
    let KEY_PLAYER_ID = "KEY_PLAYER_ID"
    let KEY_LIST_NAMES_SEEN = "KEY_NAMES_SEEN"
    let KEY_NUM_CORRECT = "KEY_NUM_CORRECT"
    let KEY_NUM_INCORRECT = "KEY_NUM_INCORRECT"
    
    init(playerID: Int){
        // First time we ever create a player, this initializer will be called.
        super.init();
        self.playerID = playerID;
    }
    
    func recordPersonSeen(person: HOOPerson){
        self.peopleSeen.append(person.getID())
    }
    
    func getPeopleSeen()->[Int]{
        return self.peopleSeen
    }
    
    func recordCorrectAnswer(){
        self.numCorrectAnswers++;
    }
    
    func recordIncorrectAnswer(){
        self.numIncorrectAnswers++;
    }
    
    func getCorrectIncorrect()->(Int,Int)
    {
        return (self.numCorrectAnswers, self.numIncorrectAnswers)
    }
    
    func getPercentageCorrect() -> Float {
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
        return self.playerID;
    }
    
    func reset() {
        self.peopleSeen = []
        self.numCorrectAnswers = 0
        self.numIncorrectAnswers = 0
    }
    
    // MARK: NSCoding
    required init(coder decoder: NSCoder) {
        self.playerID = decoder.decodeIntegerForKey(KEY_PLAYER_ID)
        self.peopleSeen = decoder.decodeObjectForKey(KEY_LIST_NAMES_SEEN) as! [Int]
        self.numCorrectAnswers = decoder.decodeIntegerForKey(KEY_NUM_CORRECT)
        self.numIncorrectAnswers = decoder.decodeIntegerForKey(KEY_NUM_INCORRECT)
        super.init()
    }
    
    func encodeWithCoder(coder: NSCoder) {
        coder.encodeInteger(self.playerID, forKey: KEY_PLAYER_ID)
        coder.encodeObject(self.peopleSeen, forKey: KEY_LIST_NAMES_SEEN)
        coder.encodeInteger(self.numCorrectAnswers, forKey: KEY_NUM_CORRECT)
        coder.encodeInteger(self.numIncorrectAnswers, forKey: KEY_NUM_INCORRECT)
    }
}
