//
//  AppDelegate.m
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "AppDelegate.h"
#import "HOOPlayBook.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *viewController = [storyboard instantiateInitialViewController];
    self.window.rootViewController = viewController;
    
    return YES;
}

-(void)applicationDidEnterBackground:(UIApplication *)application
{
    [[HOOPlayBook sharedInstance] saveChanges];
}

@end
