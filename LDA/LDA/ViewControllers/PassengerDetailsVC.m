//
//  PassengerDetailsVC.m
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//
#import "PassengerDetailsVC.h"

@interface PassengerDetailsVC ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *firstNameView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;
@property (weak, nonatomic) IBOutlet UIView *lastNameView;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTF;
@property (weak, nonatomic) IBOutlet UIView *emailView;
@property (weak, nonatomic) IBOutlet UITextField *emailTF;
@property (weak, nonatomic) IBOutlet UIView *phoneView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTF;
@property (weak, nonatomic) IBOutlet UIView *alternativePhoneView;
@property (weak, nonatomic) IBOutlet UITextField *alternativePhoneTF;
@property (weak, nonatomic) IBOutlet UIView *preferredFlightView;
@property (weak, nonatomic) IBOutlet UITextField *preferredFlightTF;
@property (weak, nonatomic) IBOutlet UIView *commentView;
@property (weak, nonatomic) IBOutlet UITextView *commentTextView;

@end

@implementation PassengerDetailsVC

-(void)initView{
    [super initView];
    [self initialisation];
}

-(void)initialisation{
    self.title = @"Passenger Details";
    [self settingBorderToView:self.firstNameView];
    [self settingBorderToView:self.lastNameView];
    [self settingBorderToView:self.emailView];
    [self settingBorderToView:self.phoneView];
    [self settingBorderToView:self.alternativePhoneView];
    [self settingBorderToView:self.preferredFlightView];
    [self settingBorderToView:self.commentView];
}

-(void)settingBorderToView:(UIView *)view{
    view.layer.borderColor = LDAAPPCOMMONBLUECOLOR.CGColor;
    view.layer.borderWidth = 1;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Text Field Delegates

-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    if(textField == self.firstNameTF){
        [self.lastNameTF becomeFirstResponder];
    }
    else if(textField == self.lastNameTF){
        [self.emailTF becomeFirstResponder];
    }
    else if(textField == self.lastNameTF){
        [self.emailTF becomeFirstResponder];
    }
    else if(textField == self.emailTF){
        [self.phoneTF becomeFirstResponder];
    }
    else if(textField == self.phoneTF){
        [self.alternativePhoneTF becomeFirstResponder];
    }
    else if(textField == self.alternativePhoneTF){
        [self.preferredFlightTF becomeFirstResponder];
    }
    else if (textField == self.preferredFlightTF){
        [self.commentTextView becomeFirstResponder];
    }
    return YES;
}

#pragma mark - Actions

- (IBAction)tapGestureAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
