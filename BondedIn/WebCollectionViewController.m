//
//  ViewController.m
//  URLNavigation
//
//  Created by Silvio Jaureguibehere on 11/8/13.
//  Copyright (c) 2013 Silvio Jaureguibehere. All rights reserved.
//

#import "WebCollectionViewController.h"

@interface WebCollectionViewController () {
}

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (weak, nonatomic) IBOutlet UILabel *noItemsLabel;
@property (strong, nonatomic) UIWebView* leftView;
@property (strong, nonatomic) UIWebView* currentView;
@property (strong, nonatomic) UIWebView* rightView;
@property (weak, nonatomic) IBOutlet UIButton *leftButton;
@property (weak, nonatomic) IBOutlet UIButton *rightButton;

- (IBAction)buttonTapped:(id)sender;

-(void) setup;
-(void) setupWithUrlCount: (int) urlCount;
-(void) annimateCurrentViewTo: (UIView*) view;
-(void) deleteCurrentUrl;

 
@end


@implementation WebCollectionViewController

-(id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]){
        self.leftView = [[UIWebView alloc] init];
        self.currentView = [[UIWebView alloc] init];
        self.rightView = [[UIWebView alloc] init];
    }
    return self;
}

-(void) setDataSource:(id<WebCollectionViewControllerDataSource>)dataSource {
    _dataSource = dataSource;
}

-(void) setup {
    int urlCount = 0;
    if (self.dataSource) {
        urlCount = [self.dataSource urlCountInWebCollectionViewController:self];
    }
    [self setupWithUrlCount:urlCount];
}

-(void)setupWithUrlCount: (int) urlCount {
    [self.leftView removeFromSuperview];
    [self.currentView removeFromSuperview];
    [self.rightView removeFromSuperview];
    if (!urlCount) {
        _urlIndex = -1;
        self.pageControl.numberOfPages = 1;
        self.pageControl.currentPage = 0;
    } else {
        _urlIndex = 0;
        self.pageControl.numberOfPages = urlCount;
        self.pageControl.currentPage = 0;
        [self.scrollView addSubview: self.currentView];
        [self.scrollView addSubview: self.leftView];
        [self.scrollView addSubview: self.rightView];
        [self loadWebView: self.currentView withIndex: _urlIndex];
        if (_urlIndex < urlCount - 1) {
            [self loadWebView: self.rightView withIndex: _urlIndex+1];
        }
    }

}
-(void) loadWebView:(UIWebView*) webView withIndex: (int) index {
    NSString* urlString = [self.dataSource webCollectionViewController:self urlForIndex:index];
    NSURL* url = [NSURL URLWithString:urlString];
    NSURLRequest* request= [NSURLRequest requestWithURL:url];
    [webView loadRequest: request];
}

-(void) setupView: (UIView*) view nextToView: (UIView*) referenceView isLeft: (BOOL) isLeft {
    CGSize size = referenceView.frame.size;
    float delta = size.width;
    if (isLeft) delta *= -1;
    float x = referenceView.frame.origin.x + delta;
    view.frame = CGRectMake(x, referenceView.frame.origin.y, size.width, size.height);
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self setup];
}

-(void) viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    [self relayoutViews];
}
-(void) relayoutViews {
    self.leftView.hidden = YES;
    self.currentView.hidden = YES;
    self.rightView.hidden = YES;
    
    if (!self.pageControl.numberOfPages) {
        self.noItemsLabel.hidden = NO;
        self.leftButton.hidden = YES;
        self.rightButton.hidden = YES;
        self.scrollView.contentSize = self.scrollView.frame.size;
    } else {
        self.noItemsLabel.hidden = YES;
        self.leftButton.hidden = NO;
        self.rightButton.hidden = NO;
        self.currentView.hidden = NO;
        CGSize pageSize = CGSizeMake(self.scrollView.frame.size.width, self.scrollView.frame.size.height);
        CGPoint pageOrigin = CGPointMake(pageSize.width * self.pageControl.currentPage, 0);
        self.currentView.frame = CGRectMake(pageOrigin.x, pageOrigin.y, pageSize.width, pageSize.height);
        [self setupView: self.leftView nextToView: self.currentView isLeft: YES];
        [self setupView: self.rightView nextToView: self.currentView isLeft: NO];
        if (_urlIndex < self.pageControl.numberOfPages - 1) {
            self.rightView.hidden = NO;
        }
        self.scrollView.contentSize = CGSizeMake(self.scrollView.frame.size.width * self.pageControl.numberOfPages, self.scrollView.frame.size.height);
    }

}

-(void) deleteCurrentUrl {
    // replace current with right
    UIWebView* temp = self.rightView;
    //CGRect tempFrame = self.rightView.frame;
    self.rightView.frame = self.currentView.frame;
    self.rightView = self.currentView;
    //self.currentView.frame = tempFrame;
    self.currentView = temp;
    
    // decrease pageNumber
    self.pageControl.numberOfPages--;
    // cargar right si corresponde
    if (_urlIndex == self.pageControl.numberOfPages) {
        _urlIndex --;
    }
    if (_urlIndex < self.pageControl.numberOfPages - 1) {
        [self loadWebView: self.rightView withIndex: _urlIndex+1];
    }
    [self relayoutViews];
    [self.view setNeedsDisplay];
}

- (IBAction)buttonTapped:(id)sender {
    [self.delegate webCollectionViewController: self buttonPressedIsLeft: (sender == self.leftButton)];
    CGRect currentFrame = self.currentView.frame;
    [UIView animateWithDuration: 0.5f
                     animations:^{
                         self.currentView.frame = [sender frame];
                         float clockwise = (sender == self.leftButton)? +0.001 : -0.001;
                         self.currentView.transform = CGAffineTransformMakeRotation(M_PI+clockwise);
                     }
                     completion: ^(BOOL what){
                         [UIView animateWithDuration: 0.5f
                                          animations:^{
                                              self.rightView.frame = currentFrame;
                                          }
                                          completion: nil
                          ];
                         [self deleteCurrentUrl];
                     }];
}


-(void) annimateCurrentViewTo:(UIView *)view {
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Scroll View delegate


- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    // Update the page when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.pageControl.currentPage != page) {
        self.pageControl.currentPage = page;
        if (page < _urlIndex){
            self.rightView.hidden = NO;
            UIWebView* temp = self.leftView;
            self.leftView = self.rightView;
            self.rightView = self.currentView;
            self.currentView = temp;
            [self setupView:self.leftView nextToView:self.currentView isLeft:YES];
            if (page > 0) {
                [self loadWebView: self.leftView withIndex: page-1];
            } else {
                self.leftView.hidden = YES;
            }
            
        } else {
            self.leftView.hidden = NO;
            UIWebView* temp = self.rightView;
            self.rightView = self.leftView;
            self.leftView = self.currentView;
            self.currentView = temp;
            [self setupView:self.rightView nextToView:self.currentView isLeft:NO];
            if (page < self.pageControl.numberOfPages - 1) {
                [self loadWebView: self.rightView withIndex: page+1];
            } else {
                self.rightView.hidden = YES;
            }
        }
        _urlIndex = page;
    }
}



@end
