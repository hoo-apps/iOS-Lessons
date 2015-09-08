//
//  HOOUploadPersonController.m
//  HOOParseApp
//
//  Created by Alex Ramey on 4/8/15.
//  Copyright (c) 2015 Alex Ramey. All rights reserved.
//

#import "HOOUploadPersonController.h"
#import "Parse.h"

@interface HOOUploadPersonController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, weak) IBOutlet UITextField *nameField;
@property (nonatomic, weak) IBOutlet UIImageView *imageField;

@end

@implementation HOOUploadPersonController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITapGestureRecognizer* tapBackground = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard:)];
    [tapBackground setNumberOfTapsRequired:1];
    [self.view addGestureRecognizer:tapBackground];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pickImage:(id)sender
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    }
    else
    {
        if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
        {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed." message:@"Can't select pictures with this device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [alert show];
        }
    }
    
    
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)uploadNewPerson:(id)sender
{
    if ([_nameField.text caseInsensitiveCompare:@"Enter Name"] != NSOrderedSame &&
        [_nameField.text caseInsensitiveCompare:@""] != NSOrderedSame &&
        _imageField.image != nil)
    {
        // Convert to JPEG with 50% quality
        NSData* data = UIImageJPEGRepresentation(_imageField.image, 0.5f);
        NSString *fileName = [_nameField.text stringByAppendingString:@"Face.jpg"];
        PFFile *imageFile = [PFFile fileWithName:fileName data:data];
        
        // Save the image to Parse
        [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                PFObject *person = [PFObject objectWithClassName:@"Person"];
                person[@"Name"] = _nameField.text;
                person[@"Face"] = imageFile;
                [person saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                    if (succeeded)
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Success!" message:@"Person Upload Complete." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                    }
                    else
                    {
                        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Person Upload Fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                        [alert show];
                    }
                }];
            }
            else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Fail" message:@"Image Upload Fail." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
                [alert show];
            }
        }];
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Failed." message:@"You must provide a name and a picture" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    
}

- (IBAction)dismissKeyboard:(id)sender
{
    [self.view endEditing:YES];
}

#pragma mark - UIImagePickerController Delegate Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    _imageField.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
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
