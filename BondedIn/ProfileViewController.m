//
//  ProfileViewController.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/11/13.
//
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController


- (void)setProfile:(Fit*)profileItem
{
   _profile=profileItem;
   _urlLinkedin=_profile.fitProfile.publicProfileUrl;
   
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.webView.delegate = self;
    [self loadProfileWebView];
    
}

- (BOOL) webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
   self.activityIndicator.hidden=FALSE;
   [self.activityIndicator startAnimating];
   return YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.activityIndicator.hidden=TRUE;
    [self.activityIndicator stopAnimating];
}

- (void)loadProfileWebView
{
    NSURL * urlReq = [NSURL URLWithString:_urlLinkedin];
    NSURLRequest *req = [NSURLRequest requestWithURL:urlReq];
    [_webView loadRequest:req];
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //Open the Contact View, to send mail, do a call or add a note
    if ([[segue identifier] isEqualToString:@"contactView"]) {
        [[segue destinationViewController] setContact:_profile];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
   }

@end
