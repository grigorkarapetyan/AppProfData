//
//  CorpProfileViewController.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/25/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "CorpProfileViewController.h"
#import "CorpTabBarViewController.h"
#import "DataManager.h"
#import "CorporateUser+CoreDataProperties.h"

@interface CorpProfileViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *companyNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *sectorLabel;

@property (weak, nonatomic) IBOutlet UIButton *changePicture;
@property (weak, nonatomic) IBOutlet UIImageView *profilePicture;
@property (nonatomic) CorporateUser *corpUser;

@end

@implementation CorpProfileViewController

- (void) viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.logInEmail = [[DataManager sharedManager] needMail];
    NSLog(@"email is %@",self.logInEmail);
    self.corpUser = [[self fetchNeedUser] objectAtIndex:0];
    self.companyNameLabel.text = self.corpUser.companyName;
    self.typeLabel.text = self.corpUser.type;
    self.sectorLabel.text = self.corpUser.sector;
    if (self.corpUser.image) {
        self.profilePicture.image = [UIImage imageWithData:self.corpUser.image];
    }
}
//  Fetching from CORE DATA
- (NSArray <CorporateUser *>*)fetchNeedUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CorporateUser"];
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
    self.corpUser.image = imageData;
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
