//
//  HOOAddPlayViewController.h
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HOOAddPlayViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextField *nameField;
@property (nonatomic, strong) IBOutlet UITextField *descriptionField;
@property (nonatomic, strong) IBOutlet UILabel *yardsLabel;
@property (nonatomic, strong) IBOutlet UISlider *yardsSlider;
@property (nonatomic, strong) IBOutlet UISegmentedControl *playTypeControl;
@property (nonatomic, strong) IBOutlet UIButton *doneButton;

@end
