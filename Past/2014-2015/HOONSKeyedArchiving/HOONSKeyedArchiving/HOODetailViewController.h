//
//  HOODetailViewController.h
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HOOFootballPlay.h"

@interface HOODetailViewController : UIViewController

@property (nonatomic, strong) HOOFootballPlay *play;
@property (nonatomic, strong) IBOutlet UILabel *playDetails;

@end
