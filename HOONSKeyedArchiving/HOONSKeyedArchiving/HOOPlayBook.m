//
//  HOOPlayBook.m
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "HOOPlayBook.h"

@implementation HOOPlayBook

static NSString * const PLAYBOOK_KEY = @"PLAYBOOK_KEY";

//This is the "Singelton Design Pattern" and is often used with object stores.
//By calling sharedInstance, we always get a pointer to this single playbook.
//This prevents the problem of creating multiple playbooks and being unsure which one we're talking to.
//For something like a playbook, we only want there to be one that holds all the plays.

+(HOOPlayBook *)sharedInstance
{
    static HOOPlayBook *sharedStore = nil;
    
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        //this is only executed the first time sharedInstance is invoked
        sharedStore = [[HOOPlayBook alloc] init];
    });
    
    return sharedStore;
}

-(id)init
{
    self = [super init];
    if (self)
    {
        //custom initialization
    }
    return self;
}

-(void)addPlay:(HOOFootballPlay *)play
{
    //if plays hasn't been initialized yet, this will do it because self.plays is like [self plays] which runs the code in the next method
    _plays = self.plays;
    
    [_plays addObject:play];
}

//override the "plays" property's getter
-(NSArray *)plays
{
    if (!_plays)
    {
        _plays = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self filePathForKey:PLAYBOOK_KEY]] mutableCopy];
        
        if (!_plays)
        {
            _plays = [[NSMutableArray alloc] init];
        }
    }
    
    return _plays;
}

-(void)saveChanges
{
    [NSKeyedArchiver archiveRootObject:_plays toFile:[self filePathForKey:PLAYBOOK_KEY]];
}

-(NSString *)filePathForKey:(NSString *)key
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    
    return [documentDirectory stringByAppendingPathComponent:key];
}

@end
