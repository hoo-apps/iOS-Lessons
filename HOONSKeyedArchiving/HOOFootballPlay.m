//
//  FootballPlay.m
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "HOOFootballPlay.h"



@implementation HOOFootballPlay

//defining these up here defends against typos below. You only want to type the literals once
static NSString * const NAME_KEY = @"NAME_KEY";
static NSString * const PLAY_DESCRIPTION_KEY = @"PLAY_DESCRIPTION_KEY";
static NSString * const TYPE_KEY = @"TYPE_KEY";
static NSString * const EXPECTED_YARDS_KEY = @"EXPECTED_YARDS_KEY";

#pragma mark - NSCoding Protocol Methods
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    
    _name = [aDecoder decodeObjectForKey:NAME_KEY];
    _playDescription = [aDecoder decodeObjectForKey:PLAY_DESCRIPTION_KEY];
    _type = [aDecoder decodeObjectForKey:TYPE_KEY];
    _expectedYards = [aDecoder decodeObjectForKey:EXPECTED_YARDS_KEY];
    
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:_name forKey:NAME_KEY];
    [aCoder encodeObject:_playDescription forKey:PLAY_DESCRIPTION_KEY];
    [aCoder encodeObject:_type forKey:TYPE_KEY];
    [aCoder encodeObject:_expectedYards forKey:EXPECTED_YARDS_KEY];
}

@end
