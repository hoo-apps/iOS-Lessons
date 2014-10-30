//
//  HOOMapViewController.m
//  HOOMap
//
//  Created by Alex Ramey on 10/29/14.
//  Copyright (c) 2014 HooApps. All rights reserved.
//

#import "HOOMapViewController.h"
#import "HOOSEASBuilding.h"

@interface HOOMapViewController ()

@end

@implementation HOOMapViewController

//the designated initializer for view controllers in a Storyboard
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        //custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDelegate:self];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    //request permission to access the user's location
    //IMPORTANT!!!!!!
    //Add string message to Info.plist for your app with Key = NSLocationWhenInUseUsageDescription.
    //otherwise, user won't be presented with option to allow or don't allow location tracking when app is in use son.
    [_locationManager requestWhenInUseAuthorization];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    //Let's slap down an annotation on Rice
    HOOSEASBuilding *bldng = [[HOOSEASBuilding alloc] initWithCoordinate:CLLocationCoordinate2DMake(38.032768, -78.510664) buildingName:@"Rice"];
    [_mapView addAnnotation:bldng];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc
{
    //_locatoinManager holds an unsafe_unretained reference to its delegate so it needs to be told when its delegate gets destroyed
    
    //since this view controller is the only object holding a strong reference to the CLLocationManager object, the CLLocationManager object will get destroyed when this view controller gets destroyed, so the following line is actually unnecessary b/c the CLLocationManager won't persist and thereby doesn't need to know that its delegate is gone (since it's gone too!)
    
    //I'll slap the line down just for good measure though . . .
    [_locationManager setDelegate:nil];
}

#pragma mark - MKMapViewDelegate Protocol Methods

-(MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation
{
    //implement this to provide custom map marker views for the annotations
    return nil;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control
{
    //implement this be notified when the callout of an annotation is tapped
    //this is where you launch the detail view
}

#pragma mark - CLLocationManagerDelegate Methods

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    [_locationManager stopUpdatingLocation];
    
    //Get most recent location update (which is at the end of the locations array)
    CLLocation* userInitialPosition = [locations objectAtIndex:([locations count]-1)];
    
    //Center map on the user's position
    CLLocationCoordinate2D coord = [userInitialPosition coordinate];
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500, 500);
    [_mapView setRegion:region animated:YES];
    
    //you can check how far they are from SEAS and choose to center on SEAS instead of their position if you want
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    [_locationManager stopUpdatingLocation];
    
    //In this case, just zoom the map to the middle of SEAS
    CLLocationCoordinate2D coord = CLLocationCoordinate2DMake(38.032768, -78.510664);
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 500, 500);
    [_mapView setRegion:region animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status
{
    if (status == kCLAuthorizationStatusDenied)
    {
        [_mapView setShowsUserLocation:NO];
        NSLog(@"Permission Denied");
    }
    else if (status == kCLAuthorizationStatusAuthorizedWhenInUse)
    {
        [_mapView setShowsUserLocation:YES];
        [_locationManager startUpdatingLocation];
        NSLog(@"Permission Authorized");
    }
    else
    {
        //do nothing
        NSLog(@"Status %d", status);
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
