//
//  HOOPlayBook.h
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "HOOFootballPlay.h"

//This class acts as an object store
@interface HOOPlayBook : NSObject

@property (nonatomic, strong) NSMutableArray *plays;


//This "+" sign means that this is a class method, not an instance method
//You call this method like [HOOPlayBook sharedInstance];

//whereas you call instance methods like:

//HOOPlayBook *anInstanceofHooPlayBook = [[HOOPlayBook alloc] init];
//[anInstanceofHooPlayBook sharedInstance];

+(HOOPlayBook *)sharedInstance;

-(void)addPlay:(HOOFootballPlay *)play;

-(void)saveChanges;

@end
