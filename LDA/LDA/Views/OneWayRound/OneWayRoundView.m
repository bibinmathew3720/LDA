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
- (IBAction)fromButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(fromButtonActionDelegate)]){
        [self.onewayViewDelegate fromButtonActionDelegate];
    }
}
- (IBAction)toButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(toButtonActionDelegate)]){
        [self.onewayViewDelegate toButtonActionDelegate];
    }
}

- (IBAction)tripTypeButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(tripTypeButtonActionDelegateWithTF:)]){
        [self.onewayViewDelegate tripTypeButtonActionDelegateWithTF:self.tripTypeTF];
    }
}
- (IBAction)classButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(classButtonActionDelegateWithTF:)]){
        [self.onewayViewDelegate classButtonActionDelegateWithTF:self.classTF];
    }
}
- (IBAction)departButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(departButtonActionDelegateWithTF:)]){
        [self.onewayViewDelegate departButtonActionDelegateWithTF:self.departTF];
    }
}
- (IBAction)flexibilityButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(flexibiltyButtonActionDelegateWithTF:)]){
        [self.onewayViewDelegate flexibiltyButtonActionDelegateWithTF:self.flexibilityTF];
    }
}
- (IBAction)returnButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(returnButtonActionDelagateWithTF:)]){
        [self.onewayViewDelegate returnButtonActionDelagateWithTF:self.returnTF];
    }
}
- (IBAction)returnFlexibilityButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(returnFlexibilityButtonActionDelegateWithTF:)]){
        [self.onewayViewDelegate returnFlexibilityButtonActionDelegateWithTF:self.returnFlexibilityTF];
    }
}


- (IBAction)passengersButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(passengsersButtonActionDelegateWithTF:)]){
        [self.onewayViewDelegate passengsersButtonActionDelegateWithTF:self.passengersTF];
    }
}
- (IBAction)bookButtonAction:(UIButton *)sender {
    if(self.onewayViewDelegate && [self.onewayViewDelegate respondsToSelector:@selector(bookButtonActionDelegate)]){
        [self.onewayViewDelegate bookButtonActionDelegate];
    }
}

@end
