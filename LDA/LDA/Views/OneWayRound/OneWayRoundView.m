//
//  OneWayRoundView.m
//  LDA
//
//  Created by Bibin Mathew on 6/5/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "OneWayRoundView.h"

@implementation OneWayRoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)tripTypeButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(tripTypeButtonActionDelegateWithTF:)]){
        [self.onewayViewDelegate tripTypeButtonActionDelegateWithTF:self.tripTypeTF];
    }
}
- (IBAction)classButtonAction:(UIButton *)sender {
}
- (IBAction)departButtonAction:(UIButton *)sender {
}
- (IBAction)flexibilityButtonAction:(UIButton *)sender {
}
- (IBAction)passengersButtonAction:(UIButton *)sender {
}
- (IBAction)bookButtonAction:(UIButton *)sender {
}

@end
