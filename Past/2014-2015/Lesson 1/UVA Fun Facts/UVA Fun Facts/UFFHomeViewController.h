//
//  UFFHomeViewController.h
//  UVA Fun Facts
//
//  Created by Alex Ramey on 9/8/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UFFHomeViewController : UIViewController
{
    NSArray *trueFunFacts;
    NSArray *falseFunFacts;
    int answer;
    int score;
}

@property (nonatomic, weak) IBOutlet UILabel *fact;
@property (nonatomic, weak) IBOutlet UILabel *scoreLabel;
@property (nonatomic, weak) IBOutlet UIButton *trueButton;
@property (nonatomic, weak) IBOutlet UIButton *falseButton;

@end
