//
//  HOOMapViewController.h
//  HOOMap
//
//  Created by Alex Ramey on 10/29/14.
//  Copyright (c) 2014 HooApps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

//Notice the listing of the protocols to which this view controller conforms between the < . . . > below
@interface HOOMapViewController : UIViewController <MKMapViewDelegate, CLLocationManagerDelegate>


@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;


@end
