//
//  ProfileViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/11/13.
//
//

#import <UIKit/UIKit.h>
#import "Fit.h"
#import "Profile.h"
#import "ContactViewController.h"

@interface ProfileViewController : UIViewController <UIWebViewDelegate>


@property (strong, nonatomic) IBOutlet UIWebView *webView;
@property (strong, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (strong, nonatomic) NSString * urlLinkedin;
@property (strong, nonatomic) Fit* profile;


- (void)setProfile:(Fit*)profileItem;
- (void)loadProfileWebView;
- (void)contactDeveloper;


@end
