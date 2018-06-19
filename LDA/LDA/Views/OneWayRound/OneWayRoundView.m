//
//  OneWayRoundView.m
//  LDA
//
//  Created by Bibin Mathew on 6/5/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "OneWayRoundView.h"
@interface OneWayRoundView()
@property (weak, nonatomic) IBOutlet UILabel *tripTypeHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *classHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *departHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *flexibilityHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *returnFlexibilityHeadingLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengersHeadingLabel;
@property (weak, nonatomic) IBOutlet UIButton *bookButton;
@end
@implementation OneWayRoundView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)awakeFromNib{
    [super awakeFromNib];
    [self localization];
}

-(void)localization{
   self.tripTypeHeadingLabel.text = NSLocalizedString(@"TRIPTYPEHEADING", @"TRIP TYPE");
    self.classHeadingLabel.text = NSLocalizedString(@"CLASSHEADING", @"CLASS");
    self.departHeadingLabel.text = NSLocalizedString(@"DEPARTHEADING", @"DEPART");
    self.flexibilityHeadingLabel.text = NSLocalizedString(@"FLEXIBILITYHEADING", @"FLEXIBILITY");
    self.returnHeadingLabel.text = NSLocalizedString(@"RETURNHEADING", @"RETURN");
     self.returnFlexibilityLabel.text = NSLocalizedString(@"FLEXIBILITYHEADING", @"FLEXIBILITY");
    self.passengersHeadingLabel.text = NSLocalizedString(@"PASSENGERSHEADING", @"PASSENGERS");
    [self.bookButton setTitle:NSLocalizedString(@"BOOK", @"BOOK") forState:UIControlStateNormal];
}

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
