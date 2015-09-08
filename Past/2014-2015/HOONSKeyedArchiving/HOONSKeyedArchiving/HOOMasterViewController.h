//
//  HOOMasterViewController.h
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HOOMasterViewController : UITableViewController
{
    int selectedIndex;
}

@property (nonatomic, strong) NSArray *plays;

@end
