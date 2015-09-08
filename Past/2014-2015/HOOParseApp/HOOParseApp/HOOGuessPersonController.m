//
//  HOOGuessPersonController.m
//  HOOParseApp
//
//  Created by Alex Ramey on 4/8/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

#import "HOOGuessPersonController.h"
#import "Parse.h"

@interface HOOGuessPersonController ()

@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UIImageView *faceImage;

@end

@implementation HOOGuessPersonController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    
    if (self)
    {
        
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)loadNewFace:(id)sender
{
    PFQuery *query = [PFQuery queryWithClassName:@"Person"];
    query.limit = 100;
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (error)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Sorry" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
        else
        {
            PFObject *randomPerson = objects[arc4random_uniform([objects count])];
            dispatch_async(dispatch_get_main_queue(), ^{
                _nameLabel.text = randomPerson[@"Name"];
                PFFile *imageData = randomPerson[@"Face"];
                
                [imageData getDataInBackgroundWithBlock:^(NSData *data, NSError *error) {
                    if (!error)
                    {
                        dispatch_async(dispatch_get_main_queue(), ^{
                            _faceImage.image = [UIImage imageWithData:data];
                        });
                    }
                }];
            });
        }
    }];
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
