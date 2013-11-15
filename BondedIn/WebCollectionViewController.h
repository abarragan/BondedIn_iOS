//
//  ViewController.h
//  URLNavigation
//
//  Created by Silvio Jaureguibehere on 11/8/13.
//  Copyright (c) 2013 Silvio Jaureguibehere. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WebCollectionViewController;
@protocol WebCollectionViewControllerDataSource <NSObject>


-(int) urlCountInWebCollectionViewController: (WebCollectionViewController*) webViewCollectionController;
-(NSString*) webCollectionViewController: (WebCollectionViewController*) webViewCollectionController urlForIndex: (int) index;

@end


@interface WebCollectionViewController : UIViewController

@property (readonly, nonatomic)  int urlIndex;
@property (weak, nonatomic) id <WebCollectionViewControllerDataSource> dataSource;

@end


