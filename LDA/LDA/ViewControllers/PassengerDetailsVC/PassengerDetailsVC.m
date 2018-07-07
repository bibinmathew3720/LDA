//
//  PassengerDetailsVC.m
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "PassengerDetailsVC.h"

@interface PassengerDetailsVC ()<UITextFieldDelegate,UITextViewDelegate>
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
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;
@property (weak, nonatomic) IBOutlet UILabel *agreeLabel;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
    
@property (nonatomic,assign) NSString *commentsTVPlaceholder;

@end

@implementation PassengerDetailsVC

-(void)initView{
    [super initView];
    [self initialisation];
    [self localization];
    [self settingTextViewPlaceholder];
}

-(void)localization{
    self.commentsTVPlaceholder = NSLocalizedString(@"COMMENTSPLACE", @"Comments / Special Instructions");
    if ([self isArabicLanguage]){
        self.firstNameTF.placeholder = NSLocalizedString(@"First Name", @"First Name");
        self.lastNameTF.placeholder = NSLocalizedString(@"Last Name", @"Last Name");
        self.emailTF.placeholder = NSLocalizedString(@"Email", @"Email");
        self.phoneTF.placeholder = NSLocalizedString(@"Phone", @"Phone");
        self.alternativePhoneTF.placeholder = NSLocalizedString(@"Alternative Phone", @"Alternative Phone");
        self.preferredFlightTF.placeholder = NSLocalizedString(@"Preferred Flight", @"Preferred Flight");
        self.agreeLabel.text = NSLocalizedString(@"UserAgreement", @"UserAgreement");
        [self.submitButton setTitle:NSLocalizedString(@"Submit", @"Submit") forState:UIControlStateNormal];
    }
}

-(void)initialisation{
    self.title = @"Passenger Details";
    [self showLeftBarButton];
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

#pragma mark - Text View Delegates

- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.commentTextView.text = @"";
    [self settingTVTextColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.commentTextView.text.length == 0){
        [self settingTextViewPlaceholder];
        [self.commentTextView resignFirstResponder];
    }
}
-(void)textViewDidEndEditing:(UITextView *)textView{
    if(self.commentTextView.text.length == 0){
        [self settingTextViewPlaceholder];
        [self.commentTextView resignFirstResponder];
    }
}

-(void)settingTextViewPlaceholder{
    self.commentTextView.text = self.commentsTVPlaceholder;
    self.commentTextView.textColor = [UIColor lightGrayColor];
}

-(void)settingTVTextColor{
    self.commentTextView.textColor = [UIColor blackColor];
}

#pragma mark - Actions

- (IBAction)tapGestureAction:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}
- (IBAction)submitButtonAction:(UIButton *)sender {
    if([self isValidInputs]){
        [self callingSubmitTripDetailsApi];
    }
}
- (IBAction)agreeButtonAction:(UIButton *)sender {
    sender.selected = !sender.isSelected;
}
- (IBAction)agreeTapGestureAction:(UITapGestureRecognizer *)sender {
    [self performSegueWithIdentifier:@"passengerDetailsToWebView" sender:self];
}

#pragma mark - Validation

-(BOOL)isValidInputs{
    BOOL isValid = YES;
    NSString *messageString = @"";
    if([self.firstNameTF.text empty]){
        isValid = NO;
        messageString = NSLocalizedString(@"Please enter first name", @"Please enter first name");
    }
    else if([self.lastNameTF.text empty]){
        isValid = NO;
        messageString = NSLocalizedString(@"Please enter last name", @"Please enter last name");
    }
    else if([self.emailTF.text empty]){
        isValid = NO;
        messageString = NSLocalizedString(@"Please enter email id", @"Please enter email id");
    }
    else if(![self.emailTF.text validEmail]){
        isValid = NO;
        messageString = NSLocalizedString(@"Please enter valid email id", @"Please enter valid email id");
    }
    else if([self.phoneTF.text empty]){
        isValid = NO;
        messageString = NSLocalizedString(@"Please enter phone number", @"Please enter phone number");
    }
    else if(![self.agreeButton isSelected]){
        isValid = NO;
        messageString = NSLocalizedString(@"Please accept Terms and Conditions", @"Please accept Terms and Conditions");
    }
    if(!isValid){
        [self showAlertWithTitle:NSLocalizedString(@"Warning", @"Warning") Message:messageString WithCompletion:^{
            
        }];
    }
    return isValid;
}

-(id)creatingJsonForPassengerDetails{
    NSMutableDictionary *passengerDetails = [[NSMutableDictionary alloc] init];
    [passengerDetails setValue:self.alternativePhoneTF.text forKey:@"phone2"];
    if(![self.commentTextView.text isEqualToString:self.commentsTVPlaceholder])
        [passengerDetails setValue:self.commentTextView.text forKey:@"comments"];
    [passengerDetails setValue:self.emailTF.text forKey:@"email"];
    [passengerDetails setValue:self.firstNameTF.text forKey:@"first_name"];
    [passengerDetails setValue:self.lastNameTF.text forKey:@"last_name"];
    [passengerDetails setValue:self.phoneTF.text forKey:@"phone1"];
    [passengerDetails setValue:self.preferredFlightTF.text forKey:@"pref"];
    [passengerDetails setValue:[NSNumber numberWithBool:YES] forKey:@"terms"];
    return passengerDetails;
}

#pragma mark - Calling Submit TripDetails Api

-(void)callingSubmitTripDetailsApi{
    id passengerDetails =  [self creatingJsonForPassengerDetails];
    NSMutableDictionary *mutDictionary = [[NSMutableDictionary alloc] init];
    [mutDictionary setValue:passengerDetails forKey:@"user"];
     [mutDictionary setValue:self.tripDetails forKey:@"trip"];
    NSMutableDictionary * headerDictionary =  [self headerBody];
    NSURL *submitTripDetailsUrl = [[UrlGenerator sharedHandler] urlForRequestType:LDAURLTYPESubmitTripDetails withURLParameter:nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NetworkHandler *networkHandler = [[NetworkHandler alloc] initWithRequestUrl:submitTripDetailsUrl withBody:mutDictionary withMethodType:HTTPMethodPOST withHeaderFeild:headerDictionary];
    [networkHandler startServieRequestWithSucessBlockSuccessBlock:^(id responseObject, int statusCode) {
        NSLog(@"Response Object:%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if([[responseObject valueForKey:@"status_code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
                if(self.passengerDetailsDelegate && [self.passengerDetailsDelegate respondsToSelector:@selector(tripDetailsSubmittedDelegate)]){
                    [self.passengerDetailsDelegate tripDetailsSubmittedDelegate];
                }
                [self showAlertWithTitle:NSLocalizedString(@"Success", @"Success") Message:NSLocalizedString(@"SubmissionSuccessMessage", @"SubmissionSuccessMessage") WithCompletion:^{
                    [self.navigationController popViewControllerAnimated:YES];
                }];
            }
        }
        
    } FailureBlock:^(NSError *error, int statusCode, id errorResponseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSInteger errorCode = (long)error.code;
        if(errorCode == 1024){
            [self showAlertWithTitle:NSLocalizedString(@"Failed", @"Failed") Message:NSLocalizedString(@"NetworkNotAvail", @"Network not available") WithCompletion:nil];
        }
        else{
            [self showAlertWithTitle:NSLocalizedString(@"Failed", @"Failed") Message:NSLocalizedString(@"SubmissionFailedMessage", @"SubmissionFailedMessage") WithCompletion:nil];
        }
    }];
    
}

- (NSMutableDictionary *)headerBody {
    NSMutableDictionary * headerDictionary = [[NSMutableDictionary alloc]init];
    [headerDictionary setValue:@"application/json" forKey:@"Content-Type"];
    return headerDictionary;
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
