//
//  CorporateRegViewController.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/12/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "CorporateRegViewController.h"
#import "CorpRegTableViewCell.h"
#import "CorporateInfo.h"
#import "DataManager.h"
#import "IndividualUser+CoreDataClass.h"
#import "CorporateUser+CoreDataClass.h"
#import "CorporateUser+CoreDataProperties.h"
#import "CorpProfileViewController.h"
#import "CorpTabBarViewController.h"

@interface CorporateRegViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITableView *corpRegTableView;

@property (nonatomic, copy) NSArray *needInfo;
@property (nonatomic) NSMutableArray *typedInfo;

@property (nonatomic) NSInteger selectedInfoIndex;
@end

@implementation CorporateRegViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.needInfo = @[[CorporateInfo corporateInfoWithNeedData:@"Company name"],
                      [CorporateInfo corporateInfoWithNeedData:@"Type"],
                      [CorporateInfo corporateInfoWithNeedData:@"Headquarter city"],
                      [CorporateInfo corporateInfoWithNeedData:@"Headquarter address"],
                      [CorporateInfo corporateInfoWithNeedData:@"Sector"],
                      [CorporateInfo corporateInfoWithNeedData:@"Phone"],
                      [CorporateInfo corporateInfoWithNeedData:@"Email"],
                      [CorporateInfo corporateInfoWithNeedData:@"Password"],
                      [CorporateInfo corporateInfoWithNeedData:@"Confirm password"]];
    
    self.title = @"Corporate registration";
    self.typedInfo = [[NSMutableArray alloc] init];
    for(int i=0; i<self.needInfo.count; i++){
        self.typedInfo[i] = @"";
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.needInfo count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CorpRegTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cellCorp" forIndexPath:indexPath];
    cell.infoTextField.tag = indexPath.row;
    cell.infoTextField.delegate = self;
    if ([[self.typedInfo objectAtIndex:indexPath.row] isEqualToString:@""]) {
        CorporateInfo *info = self.needInfo[indexPath.row];
        [cell.infoTextField setPlaceholder:info.needData];
    } else {
        [cell.infoTextField setText:[self.typedInfo objectAtIndex:indexPath.row]];
    }
    
    NSLog(@"%ld",(long)indexPath.row);  //checking cell log
    cell.infoTextField.secureTextEntry = (indexPath.row == 7) || (indexPath.row == 8);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)textFieldDidEndEditing:(UITextField *)textField {
    [self.typedInfo replaceObjectAtIndex:textField.tag withObject:textField.text];
    
}
- (void) textFieldDidBeginEditing:(UITextField *)textField{
  
}

- (IBAction)submitingRegistration:(id)sender {

    BOOL isReady = YES;
    //    Checking correct registration
    NSString *alertText = @"";
    if ([self.typedInfo[0] isEqualToString:@""]) {
        alertText = @"Company name is required";
    }
    if ([self.typedInfo[6] isEqualToString:@""]) {
        alertText = @"Email is required";
    }
    if ((![self.typedInfo[7] isEqualToString: self.typedInfo[8]]) || ([self.typedInfo[7]  isEqualToString: @""])) {
        alertText = @"Wrong password confirmation";

    }
    NSArray <User*>*anyUser = [self fetchAnyUser];
    if ([anyUser count] != 0)  {
        alertText = @"Existing registration with the same mail";

    }
    if (![alertText isEqualToString:@""]) {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Wrong registration"
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
        
        
        //     CORE DATA PART
        
        NSManagedObjectContext *context = [[DataManager sharedManager] managedObjectContext];
        CorporateUser *corpUser = [NSEntityDescription insertNewObjectForEntityForName:@"CorporateUser" inManagedObjectContext:context];
        corpUser.companyName = self.typedInfo[0];
        corpUser.type = self.typedInfo[1];
        corpUser.headquarterCity = self.typedInfo[2];
        corpUser.headquarterAddress = self.typedInfo[3];
        corpUser.sector = self.typedInfo[4];
        corpUser.phone = self.typedInfo[5];
        corpUser.email = self.typedInfo[6];
        corpUser.password = self.typedInfo[7];
        
        [[DataManager sharedManager] saveContext];
        
        [self goToProfile];
        
        
    }
}
- (IBAction)goToProfile {
    [self performSegueWithIdentifier:@"showingProfile" sender:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showingProfile"]) {
        CorpTabBarViewController *tabBar = [segue destinationViewController];
    
        [[DataManager sharedManager] setNeedMail:self.typedInfo[6]];
    }
}

//  Fetching from CORE DATA

- (NSArray <User *>*)fetchAnyUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@",self.typedInfo[6]];
    [fetchRequest setPredicate:predicate];
    return [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}
- (IBAction)infoTextFieldChanged:(UITextField *)textField {
    [self.typedInfo replaceObjectAtIndex:textField.tag withObject:textField.text];
}
@end












