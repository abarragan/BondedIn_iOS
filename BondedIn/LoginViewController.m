//
//  LoginViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 12/9/13.
//
//

#import "LoginViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize txtUser, txtPassword, buttonLogin;

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureComponents];
    [self showAnimations];
   
}

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender
{
    //ONLY TO TEST
    NSString * user=@"developer@mail.com";
    NSString * password=@"dev123";
    //check user
    if(![self.txtUser.text isEqualToString:user]){
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                        message:@"User information is incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        return NO;

        
    }
    else {
        //check password
        if(![self.txtPassword.text isEqualToString:password]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error"
                                                            message:@"Password information is incorrect" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            return NO;
            
        }
        else{
            //good!
            return YES;

        }
    }
    return YES;

}


- (IBAction)textViewDoneClicked:(id)sender {
    [self.txtUser resignFirstResponder];
    [self.txtPassword resignFirstResponder];
    
}

- (void) configureComponents{
    
    //TextField User
    self.txtUser.borderStyle=UITextBorderStyleNone;
    self.txtUser.layer.cornerRadius=1.0f;
    self.txtUser.layer.masksToBounds=YES;
    self.txtUser.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.txtUser.layer.borderWidth= 1.3f;
    [self.txtUser setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]];
    
    //TextField Password
    self.txtPassword.borderStyle=UITextBorderStyleNone;
    self.txtPassword.layer.cornerRadius=1.0f;
    
    self.txtPassword.layer.masksToBounds=NO;
    self.txtPassword.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    self.txtPassword.layer.borderWidth= 1.3;
    [self.txtPassword setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1]];
    
    //Button Login
    [self.buttonLogin.layer setMasksToBounds:YES];
    
    //Create Toolbar
    UIToolbar* keyboardDoneButtonView = [[UIToolbar alloc] init];
    keyboardDoneButtonView.frame=CGRectMake(0,75,180,10);
    keyboardDoneButtonView.barStyle =UIBarStyleBlackTranslucent;
    keyboardDoneButtonView.tintColor = nil;
    [keyboardDoneButtonView sizeToFit];
    UIBarButtonItem *flexibleSpaceLeft = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    //Create button "Done"
    UIBarButtonItem* doneButton = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(textViewDoneClicked:) ];
    [keyboardDoneButtonView setItems:[NSArray arrayWithObjects:flexibleSpaceLeft, doneButton, nil]];
    
    //add a Accessory with toolbar
    self.txtUser.inputAccessoryView = keyboardDoneButtonView;
    self.txtPassword.inputAccessoryView = keyboardDoneButtonView;
    
    self.txtUser.hidden=TRUE;
    self.txtPassword.hidden=TRUE;
    self.buttonLogin.hidden=TRUE;
    
}

-(void) showAnimations{
    
    //Transicion Brackground
    UIImageView *animationImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 960, self.view.frame.size.height)];
    animationImageView.image = [UIImage imageNamed:@"background@960x480.png"];
    
    
    //Transicion Couple walking
    UIImageView *animationIVCouple = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100, self.view.frame.size.height-210, 200, 200)];
    animationIVCouple.image = [UIImage imageNamed:@"coupleWalking.png"];
    
    //Transicion Guy walking
    UIImageView *animationIVGuy = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width-200, self.view.frame.size.height-210, 960, 189)];
    animationIVGuy.image = [UIImage imageNamed:@"guyWalking.png"];
    
    
    
    //Start animation -FIRST TRANSITION-
    [UIView animateWithDuration:1.5 delay:1.0 options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         animationImageView.frame = CGRectMake(-0.5 * self.view.frame.size.width, 0,960, self.view.frame.size.height);
                     }
                     completion:^(BOOL finished) {
                         //SECOND TRANSITION-
                         [UIView animateWithDuration:1.5 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              animationImageView.frame = CGRectMake(-self.view.frame.size.width, 0,960, self.view.frame.size.height);
                                          }
                                          completion:^(BOOL finished) {}];
                         //couple walking
                         [UIView animateWithDuration:1.7 delay:0.0 options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              animationIVCouple.frame = CGRectMake(self.view.frame.size.width-500, self.view.frame.size.height-210, 200, 200);
                                          }
                                          completion:^(BOOL finished) {}];
                         
                         //guy walking
                         [UIView animateWithDuration:1.7 delay:0.0  options:UIViewAnimationOptionCurveEaseInOut
                                          animations:^{
                                              animationIVGuy.frame = CGRectMake(self.view.frame.size.width-240, self.view.frame.size.height-210, 230, 200);
                                          }
                                          //FINISH ANIMATION- SHOW LOGIN
                                          completion:^(BOOL finished) {
                                              
                                              self.txtUser.hidden=FALSE;
                                              self.txtPassword.hidden=FALSE;
                                              self.buttonLogin.hidden=FALSE;
                                              animationImageView.alpha=0.4;
                                              animationIVCouple.alpha=0.4;
                                              animationIVGuy.alpha=0.4;
                                          }];
                            
                     }];
    
    //-FIRST TRANSITION- couple 
    [UIView animateWithDuration:1.0 delay:0.7  options:UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         animationIVCouple.frame = CGRectMake(self.view.frame.size.width-280, self.view.frame.size.height-210, 200, 200);
                     }
                     completion:^(BOOL finished) {
                         
                     }];
    
    [self.view addSubview:animationImageView];
    [self.view addSubview:animationIVCouple];
    [self.view addSubview:animationIVGuy];
    [self.view addSubview:txtUser];
    [self.view addSubview:txtPassword];
    [self.view addSubview:buttonLogin];

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
