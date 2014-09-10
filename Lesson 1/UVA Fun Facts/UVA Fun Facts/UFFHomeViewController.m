//
//  UFFHomeViewController.m
//  UVA Fun Facts
//
//  Created by Alex Ramey on 9/8/14.
//  Copyright (c) 2014 hooapps. All rights reserved.
//

#import "UFFHomeViewController.h"

@interface UFFHomeViewController ()

@end

@implementation UFFHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        trueFunFacts = @[@"Dr. Seuss was denied admittance to UVA. Rumor has it the name for the fictional town of \"Whoville\" was a pun off the University's nickname, \"Hoos\".", @"The official mascot for UVA is the cavaliers, but they unofficially adopted the Wahoos, a fish that can drink its weight in water, as their second mascot. While it was originally shouted as an insult by an opposing school at a football game, the students at UVA instead adopted it as a name.", @"UVA was founded in 1819 by Thomas Jefferson, who was this nation's first secretary of state, second vice president, and third president.", @"UVA's undergraduate student body is 65% out of state", @"The founder of MIT was an engineering professor who came from UVA"];
       falseFunFacts = @[@"In May 2005, there was a water slide that went down the middle of the UVA Lawn", @"The Rotunda has been under construction for 99.1 % of its life.", @"UVA was founded in 1831 by Christopher Columbus", @"UVA has put 15 monkeys on the moon.", @"UVA's current President is Chuck Norris, and he lives in the Steam Tunnels with the Ninja Turtles."];
        score = 0;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self updateFactAndScore];
}

-(void)updateFactAndScore
{
    if (score == 10)
    {
        UIAlertView *a = [[UIAlertView alloc] initWithTitle:@"You Win" message:@"Nice job!" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [a show];
        score = 0;
    }
    
    int trueFact = arc4random_uniform(2);
    int random = arc4random_uniform(5);
    
    if (trueFact == 0)
    {
        [_fact setText:falseFunFacts[random]];
    }
    else
    {
        [_fact setText:trueFunFacts[random]];
    }
    
    answer = trueFact;
    [_scoreLabel setText:[NSString stringWithFormat:@"Score: %d", score]];
}

-(IBAction)buttonPressed:(id)sender
{
    UIButton *tappedButton = (UIButton *)sender;
    if ([tappedButton.titleLabel.text caseInsensitiveCompare:@"True"] == NSOrderedSame)
    {
        if (answer == 1)
        {
            score++;
        }
        else
        {
            score--;
        }
    }
    else //False was tapped
    {
       (answer == 0) ? score++ : score--;
    }
    
    [self updateFactAndScore];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
