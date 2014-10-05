//
//  HOODetailViewController.m
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "HOODetailViewController.h"

@interface HOODetailViewController ()

@end

@implementation HOODetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSArray *playTypes = @[@"Rushing Play", @"Passing Play", @"Special Teams Play", @"Trick Play"];
    // Do any additional setup after loading the view.
    
    NSString *playType = [playTypes objectAtIndex:[_play.type intValue]];
    
    _playDetails.text = [NSString stringWithFormat:@"Name: %@\n\nType: %@\n\nDescription: %@\n\nExpected Yards: %@\n\n", _play.name, _play.playDescription, [_play.expectedYards stringValue], playType];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
