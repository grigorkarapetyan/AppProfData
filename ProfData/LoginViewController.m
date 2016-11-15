//
//  LoginViewController.m
//  ProfData
//
//  Created by Grigor Karapetyan on 10/12/16.
//  Copyright © 2016 Grigor Karapetyan. All rights reserved.
//

#import "LoginViewController.h"
#import "IndividualUser+CoreDataProperties.h"
#import "CorporateUser+CoreDataProperties.h"
#import "DataManager.h"
#import "CorpTabBarViewController.h"
#import "IndTabBarViewController.h"


@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;

@property (nonatomic,copy) NSString *logInEmail;

@end

@implementation LoginViewController

- (void) viewWillAppear:(BOOL)animated {
    self.emailTextField.text = @"";
    self.passwordTextField.text = @"";
}
- (void)viewDidLoad {

    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (IBAction)registrationRequest:(id)sender {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"User type"
                                                                   message:@"Registration as..."
                                                            preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* individualButton = [UIAlertAction actionWithTitle:@"Individual"
                                                               style:UIAlertActionStyleDefault
                                                             handler:^(UIAlertAction * action) {
                                   UIViewController *individualRegistration = [self.storyboard instantiateViewControllerWithIdentifier:@"individualRegistration"];
                                   [self.navigationController pushViewController:individualRegistration                             animated:YES];
                                    } ];
    
    UIAlertAction* corporateButton = [UIAlertAction actionWithTitle:@"Corporate"
                                                              style:UIAlertActionStyleDefault
                                                            handler:^(UIAlertAction * action) {
                                            UIViewController *individualRegistration = [self.storyboard instantiateViewControllerWithIdentifier:@"corporateRegistration"];
                                          [self.navigationController pushViewController:individualRegistration                             animated:YES];
                                    } ];
    UIAlertAction* cancelButton = [UIAlertAction actionWithTitle:@"Cancel"
                                                              style:UIAlertActionStyleCancel
                                                            handler:nil];
    [alert addAction:individualButton];
    [alert addAction:corporateButton];
    [alert addAction:cancelButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (IBAction)loginAction:(id)sender {
    BOOL userExist = NO;
    BOOL isIndividual = NO;
    NSArray <IndividualUser*>*individualUser = [self fetchIndividualUser];
        if ([individualUser count] != 0)  {
            IndividualUser *indUser = [individualUser objectAtIndex:0];
            BOOL rightPassword = [self checkPassword:indUser];
            if (rightPassword) {
            self.logInEmail = indUser.email;
            userExist = YES;
            isIndividual = YES;
            }
        }
    if (!userExist) {
        NSArray <CorporateUser*>*corporateUser = [self fetchCorporateUser];
        if ([corporateUser count] != 0) {
            CorporateUser *corpUser = [corporateUser objectAtIndex:0];
                BOOL rightPassword = [self checkPassword:corpUser];
                if (rightPassword) {
                    self.logInEmail = corpUser.email;
                    userExist = YES;
                }
        }
    }
    if (userExist) {
        [self goToProfile:isIndividual];
    } else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed logIn" message:@"Wrong email or/and password" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okButton = [UIAlertAction actionWithTitle:@"OK"
                                                               style:UIAlertActionStyleCancel
                                                             handler:nil];
        [alert addAction:okButton];
        [self presentViewController:alert animated:YES completion:nil];
    }
}

//              Checking password
- (BOOL)checkPassword:(User *) user {
    if ([user.password isEqualToString:self.passwordTextField.text]) {
        return YES;
    } else {
        return NO;
    }
}

//              Switching to USER PROFILE
- (IBAction)goToProfile:(BOOL)isIndividual {
    if (isIndividual) {
        [self performSegueWithIdentifier:@"showingIndProfile" sender:nil];

    } else {
        [self performSegueWithIdentifier:@"showingCorpProfile" sender:nil];
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"showingIndProfile"]) {
        IndTabBarViewController *tabBar = [segue destinationViewController];
        [[DataManager sharedManager] setNeedMail:self.logInEmail];
    };
    if ([segue.identifier isEqualToString:@"showingCorpProfile"]) {
        CorpTabBarViewController *tabBar = [segue destinationViewController];
        [[DataManager sharedManager] setNeedMail:self.logInEmail];
    };
}

//FETCHING PART

//              Fetching all INDIVIDUAL USERS
- (NSArray <IndividualUser *>*)fetchIndividualUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"IndividualUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@",self.emailTextField.text];
    [fetchRequest setPredicate:predicate];
    return [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}
//              Fetching all CORPORATE USERS
- (NSArray <CorporateUser *>*)fetchCorporateUser {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"CorporateUser"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@",self.emailTextField.text];
    [fetchRequest setPredicate:predicate];
    return [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}

//              Fetching all USERS
- (NSArray <User *>*)fetchAllUsers {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"email == %@",self.emailTextField.text];
    [fetchRequest setPredicate:predicate];
    return [[[DataManager sharedManager] managedObjectContext] executeFetchRequest:fetchRequest error:nil];
}
@end
