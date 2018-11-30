//
//  SearchTVC.h
//  LDA
//
//  Created by "" on 6/10/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SearchTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (nonatomic, strong) id locationDetails;
@end
