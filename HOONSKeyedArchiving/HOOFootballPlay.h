//
//  FootballPlay.h
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <Foundation/Foundation.h>

/*
 In this project, a FootballPlay object is our model object. In order to be saved to the phone, it must conform to the NSCoding Protocol, which is why I added <NSCoding> after NSObject below. Conforming to a protocol simply means providing definitions for certain methods that the protocol defines. The protocol lists a bunch of method names but no method bodies. Some of the protocol's defined methods are optional and some are required to be implemented by a conforming class.
 */

@interface HOOFootballPlay : NSObject <NSCoding>

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *playDescription;
@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, strong) NSNumber *expectedYards;

@end
