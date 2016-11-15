//
//  IndividualRegViewController.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/12/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "IndividualRegViewController.h"
#import "IndRegTableViewCell.h"
#import "BirthDateTableViewCell.h"
#import "IndividualInfo.h"
#import "DataManager.h"
#import "IndividualUser+CoreDataClass.h"
#import "CorporateUser+CoreDataClass.h"
#import "IndProfileViewController.h"
#import "IndTabBarViewController.h"

@interface IndividualRegViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *indRegTableView;

@property (nonatomic,copy) NSArray *needInfo;
@property (nonatomic) NSMutableArray *typedInfo;

@property (nonatomic) NSInteger selectedInfoIndex;
@end

@implementation IndividualRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.needInfo = @[[IndividualInfo individualInfoWithNeedData:@"First name"],
                      [IndividualInfo individualInfoWithNeedData:@"Last name"],
                      [IndividualInfo individualInfoWithNeedData:@"Date of birth"],
                      [IndividualInfo individualInfoWithNeedData:@"City"],
                      [IndividualInfo individualInfoWithNeedData:@"Education"],
                      [IndividualInfo individualInfoWithNeedData:@"Specialization"],
                      [IndividualInfo individualInfoWithNeedData:@"Work experience"],
                      [IndividualInfo individualInfoWithNeedData:@"Current employer"],
                      [IndividualInfo individualInfoWithNeedData:@"Current position"],
                      [IndividualInfo individualInfoWithNeedData:@"Skills"],
                      [IndividualInfo individualInfoWithNeedData:@"Interests"],
                      [IndividualInfo individualInfoWithNeedData:@"Languages"],
                      [IndividualInfo individualInfoWithNeedData:@"Phone"],
                      [IndividualInfo individualInfoWithNeedData:@"Email"],
                      [IndividualInfo individualInfoWithNeedData:@"Password"],
                      [IndividualInfo individualInfoWithNeedData:@"Confirm password"]];
    
    self.title = @"Individual registration";
    self.typedInfo = [[NSMutableArray alloc] init];
    for(int i=0; i<self.needInfo.count; i++){
        self.typedInfo[i] = @"";
    }
 
    [self.typedInfo replaceObjectAtIndex:2 withObject:[NSDate date]];

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
        return [self.needInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 2){
       IndRegTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellBirth" forIndexPath:indexPath];
        return cell;
    } else {
    IndRegTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellInd" forIndexPath:indexPath];
    
    cell.infoTextField.tag = indexPath.row;
    cell.infoTextField.delegate = self;
    if ([[self.typedInfo objectAtIndex:indexPath.row] isEqualToString:@""]) {
        IndividualInfo *info = self.needInfo[indexPath.row];
        [cell.infoTextField setPlaceholder:info.needData];
    } else {
        [cell.infoTextField setText:[self.typedInfo objectAtIndex:indexPath.row]];
    }
    
    NSLog(@"%ld",(long)indexPath.row); //checking cell log
    cell.infoTextField.secureTextEntry = ((indexPath.row == 14) || (indexPath.row == 15));
    
    return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.typedInfo replaceObjectAtIndex:textField.tag withObject:textField.text];
    NSLog(@"FIELD number %ld",(long)textField.tag);
    
}
- (void) textFieldDidBeginEditing:(UITextField *)textField {

}

- (IBAction)submitingRegistration:(id)sender {
    
    BOOL isReady = YES;
//    Checking correct registration
    NSString *alertText = @"";
    if ([self.typedInfo[0] isEqualToString:@""] || [self.typedInfo[1] isEqualToString:@""]) {
        alertText = @"Firts name and Last Name are required";
    }
    if ([self.typedInfo[13] isEqualToString:@""]) {
        alertText = @"Email is required";
    }
    if ((![self.typedInfo[14] isEqualToString:self.typedInfo[15]]) || ([self.typedInfo[14]  isEqualToString: @""])) {
        alertText = @"Wrong password confirmation";
    }
    NSArray <User*>*anyUser = [self fetchAnyUser];
    if ([anyUser count] != 0)  {
        alertText = @"Existing registration with the same mail";

    }
    if (![alertText isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Complite registration"
                                                                       message:alertText
                                                                preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil];
        [alert addAction:ok];
        [self presentViewController:alert animated:YES completion:nil];
        isReady = NO;
    }

    if (isReady) {
    int i = 0;
    for (id data in self.typedInfo) {
        NSLog(@"%@ for field %@",data ,[[self.needInfo objectAtIndex:i]  needData]);//checking typed data
        i +=1;
    }
    
    
//     CORE DATA part
    
        NSManagedObjectContext *context = [[DataManager sharedManager] managedObjectContext];
        IndividualUser *indUser = [NSEntityDescription insertNewObjectForEntityForName:@"IndividualUser" inManagedObjectContext:context];

        indUser.firstName = self.typedInfo[0];
        indUser.lastName = self.typedInfo[1];
        indUser.dateOfBirth = self.typedInfo[2];
        indUser.city = self.typedInfo[3];
        indUser.education = self.typedInfo[4];
        indUser.specialization = self.typedInfo[5];
        indUser.workExperience = self.typedInfo[6];
        indUser.currentEmployer = self.typedInfo[7];
        indUser.currentPosition = self.typedInfo[8];
        indUser.skills = self.typedInfo[9];
        indUser.interests = self.typedInfo[10];
        indUser.languages = self.typedInfo[11];
        indUser.phone = self.typedInfo[12];
        indUser.email = self.typedInfo[13];
        indUser.password = self.typedInfo[14];
        
        [[DataManager sharedManager] saveContext];
        
        [self goToProfile];

    
    }
}
- (IBAction)goToProfile {
    [self performSegueWithIdentifier:@"showingProfile" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showingProfile"]) {
        IndTabBarViewController *tabBar = [segue destinationViewController];

        [[DataManager sharedManager] setNeedMail:self.typedInfo[13]];
    }
    
}

- (IBAction)birthDateChange:(UIDatePicker *)sender {
    NSLog(@"date is %@",sender.date);
    [self.typedInfo replaceObjectAtIndex:2 withObject:sender.date];
}
//  Fetching from CORE DATA

- (NSArray <User *>*)fetchAnyUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@",self.typedInfo[13]];
    [fetchRequest setPredicate:predicate];
    return [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}
- (IBAction)infoTextFieldChanged:(UITextField *)textField {
    [self.typedInfo replaceObjectAtIndex:textField.tag withObject:textField.text];
    
}
@end










