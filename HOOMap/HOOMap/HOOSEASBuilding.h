//
//  HOOSEASBuilding.h
//  HOOMap
//
//  Created by Alex Ramey on 10/29/14.
//  Copyright (c) 2014 HooApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

//These HooSeasBuilding objects conform to MKAnnotation protocol and can be added to maps
@interface HOOSEASBuilding : NSObject <MKAnnotation>
{
    CLLocationCoordinate2D latLng;
    NSString *buildingName;
}
-(id)initWithCoordinate:(CLLocationCoordinate2D)coord buildingName:(NSString *)name;

//Required property from MKAnnotation
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

//Optional properties from MKAnnotation
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, copy) NSString *subtitle;


@end
