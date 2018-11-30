//
//  SearchTVC.m
//  LDA
//
//  Created by "" on 6/10/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "SearchTVC.h"

@implementation SearchTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setLocationDetails:(id)locationDetails{
    self.locationLabel.text = [NSString stringWithFormat:@"%@ %@",[locationDetails valueForKey:@"code"],[locationDetails valueForKey:@"airport"]];
}

@end
