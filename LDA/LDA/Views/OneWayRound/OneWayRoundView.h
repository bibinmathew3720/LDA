//
//  OneWayRoundView.h
//  LDA
//
//  Created by Bibin Mathew on 6/5/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OneWayRoundViewDelegate;
@interface OneWayRoundView : UIView
@property (weak, nonatomic) IBOutlet UILabel *fromCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromPlaceLabel;
@property (weak, nonatomic) IBOutlet UILabel *toCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toPlaceLabel;
@property (weak, nonatomic) IBOutlet UITextField *tripTypeTF;
@property (weak, nonatomic) IBOutlet UILabel *tripTypeLabel;
@property (weak, nonatomic) IBOutlet UITextField *classTF;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UITextField *departTF;
@property (weak, nonatomic) IBOutlet UILabel *departDateLabel;
@property (weak, nonatomic) IBOutlet UITextField *flexibilityTF;
@property (weak, nonatomic) IBOutlet UILabel *flexibilityLabel;
@property (weak, nonatomic) IBOutlet UITextField *returnTF;
@property (weak, nonatomic) IBOutlet UILabel *returnDateLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnViewheightConstarint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *returnTypeTopConstraint;
@property (weak, nonatomic) IBOutlet UIView *returnView;
@property (weak, nonatomic) IBOutlet UIView *returnFlexibilityView;
@property (weak, nonatomic) IBOutlet UITextField *returnFlexibilityTF;
@property (weak, nonatomic) IBOutlet UILabel *returnFlexibilityLabel;


@property (weak, nonatomic) IBOutlet UITextField *passengersTF;
@property (weak, nonatomic) IBOutlet UILabel *passengersLabel;
@property (nonatomic, assign) id <OneWayRoundViewDelegate>onewayViewDelegate;
@end
@protocol OneWayRoundViewDelegate <NSObject>
-(void)fromButtonActionDelegate;
-(void)toButtonActionDelegate;
-(void)tripTypeButtonActionDelegateWithTF:(UITextField *)tf;
-(void)classButtonActionDelegateWithTF:(UITextField *)textField;
-(void)departButtonActionDelegateWithTF:(UITextField *)textField;
-(void)flexibiltyButtonActionDelegateWithTF:(UITextField *)textField;
-(void)passengsersButtonActionDelegateWithTF:(UITextField *)textField;
-(void)bookButtonActionDelegate;
@end
