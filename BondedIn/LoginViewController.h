//
//  LoginViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 12/9/13.
//
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *txtUser;
@property (strong, nonatomic) IBOutlet UITextField *txtPassword;
@property (strong, nonatomic) IBOutlet UIButton *buttonLogin;

@end
