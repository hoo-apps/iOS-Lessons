//
//  HOOAddPlayViewController.m
//  HOONSKeyedArchiving
//
//  Created by Alex Ramey on 10/5/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "HOOAddPlayViewController.h"
#import "HOOPlayBook.h"
#import "HOOFootballPlay.h"

@interface HOOAddPlayViewController ()

@end

@implementation HOOAddPlayViewController

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
    
    [_yardsSlider addTarget:self action:@selector(updateYardsLabel:) forControlEvents:UIControlEventValueChanged];
    
    [_playTypeControl setSelectedSegmentIndex:0];
    
    [_nameField setDelegate:self];
    [_descriptionField setDelegate:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)updateYardsLabel:(id)sender
{
    NSNumber *roundedYardsValue = [NSNumber numberWithInt:(int)_yardsSlider.value];
    _yardsLabel.text = [@"Expected Yards: " stringByAppendingString:[roundedYardsValue stringValue]];
}

-(IBAction)doneButtonPressed:(id)sender
{
    HOOFootballPlay *play = [[HOOFootballPlay alloc] init];
    [play setName:_nameField.text];
    [play setPlayDescription:_descriptionField.text];
    [play setExpectedYards:[NSNumber numberWithInt:(int)_yardsSlider.value]];
    [play setType:[NSNumber numberWithInteger:_playTypeControl.selectedSegmentIndex]];
    
    HOOPlayBook *playbook = [HOOPlayBook sharedInstance];
    [playbook addPlay:play];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - UITextFieldDelegate Methods


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
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
