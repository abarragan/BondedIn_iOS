//
//  ProfileTableViewCell.m
//  BondedIn
//
//  Created by Silvio Jaureguibehere on 11/18/13.
//
//

#import "ProfileTableViewCell.h"
@interface ProfileTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UILabel *namelabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *companyLabel;
@end


@implementation ProfileTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) configureWithName: (NSString*) name city: (NSString*) city company: (NSString*) company imageUrl: (NSString*) imageUrl{
    
    NSURL* url = [NSURL URLWithString: imageUrl];
    NSURLRequest* request = [NSURLRequest requestWithURL:url];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse * response,
                                               NSData * data,
                                               NSError * error) {
                               if (!error){
                                   UIImage* image = [[UIImage alloc] initWithData:data];
                                   self.imageView.image=image;
                                   [self setNeedsLayout];
                               }
                           }];
    self.namelabel.text = name;
    self.cityLabel.text = [NSString stringWithFormat:@"Province: %@", city];
    self.companyLabel.text = [NSString stringWithFormat:@"Company: %@", company];
}


@end
