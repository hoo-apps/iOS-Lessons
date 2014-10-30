//
//  HOOSEASBuilding.m
//  HOOMap
//
//  Created by Alex Ramey on 10/29/14.
//  Copyright (c) 2014 HooApps. All rights reserved.
//

#import "HOOSEASBuilding.h"

@implementation HOOSEASBuilding
-(id)initWithCoordinate:(CLLocationCoordinate2D)coord buildingName:(NSString *)name
{
    self = [super init];
    
    if (self)
    {
        latLng = coord;
        buildingName = name;
    }
    
    return self;
}

#pragma mark - MKAnnotation Protocol Properties

-(CLLocationCoordinate2D)coordinate
{
    return latLng;
}

-(NSString *)title
{
    return buildingName;
}

-(NSString *)subtitle
{
    return @"Tap for Directions";
}

-(void)setSubtitle:(NSString *)subtitle
{
    return;
}

@end
