//
//  DetailViewController.h
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/1/13.
//
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@end
