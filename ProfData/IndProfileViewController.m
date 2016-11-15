//
//  IndProfileViewController.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/19/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "IndProfileViewController.h"
#import "IndTabBarViewController.h"
#import "DataManager.h"
#import "IndividualUser+CoreDataProperties.h"

@interface IndProfileViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *firstNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *lastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateOfBirthLabel;
@property (weak, nonatomic) IBOutlet UIButton *changePicture;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (nonatomic) IndividualUser *indUser;

@end

@implementation IndProfileViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.logInEmail = [[DataManager sharedManager] needMail];
    NSLog(@"email is %@",self.logInEmail);
    self.indUser = [[self fetchNeedUser] objectAtIndex:0];
    self.firstNameLabel.text = self.indUser.firstName;
    self.lastNameLabel.text = self.indUser.lastName;
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd-MM-yyyy"];
    self.dateOfBirthLabel.text = [formatter stringFromDate:self.indUser.dateOfBirth];
    if (self.indUser.image) {
        self.profilePicture.image = [UIImage imageWithData:self.indUser.image];
    }
    
}
//  Fetching from CORE DATA
- (NSArray <IndividualUser *>*)fetchNeedUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"IndividualUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@",self.logInEmail];
    [fetchRequest setPredicate:predicate];
    return [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}
- (IBAction)changingPicture:(id)sender {
    [self  selectPhotos];
}
// Selecting Photo
- (void)selectPhotos {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
    self.profilePicture.image = image;
    NSData *imageData = UIImagePNGRepresentation(image);
    self.indUser.image = imageData;
    [[DataManager sharedManager] saveContext];

    [picker dismissViewControllerAnimated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
}

//  SIGN OUT
- (IBAction)signOutAction:(id)sender {
    
    UIViewController *loginVC = [self.storyboard instantiateViewControllerWithIdentifier:@"loginNavVC"];
    [self showViewController:loginVC sender:nil];
}

@end
