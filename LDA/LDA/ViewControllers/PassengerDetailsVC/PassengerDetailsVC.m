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
@property (weak, nonatomic) IBOutlet UIButton *agreeButton;

@end

@implementation PassengerDetailsVC

-(void)initView{
    [super initView];
    [self initialisation];
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
        messageString = @"Please enter first name";
    }
    else if([self.lastNameTF.text empty]){
        isValid = NO;
        messageString = @"Please enter last name";
    }
    else if([self.emailTF.text empty]){
        isValid = NO;
        messageString = @"Please enter email id";
    }
    else if(![self.emailTF.text validEmail]){
        isValid = NO;
        messageString = @"Please enter valid email id";
    }
    else if([self.phoneTF.text empty]){
        isValid = NO;
        messageString = @"Please enter phone number";
    }
    else if(![self.agreeButton isSelected]){
        isValid = NO;
        messageString = @"Please accept user agreement";
    }
    if(!isValid){
        [self showAlertWithTitle:APPNAME Message:messageString WithCompletion:^{
            
        }];
    }
    return isValid;
}

-(id)creatingJsonForPassengerDetails{
    NSMutableDictionary *passengerDetails = [[NSMutableDictionary alloc] init];
//    'phone2' => '9876543210',
//    'comments' => 'nyjgjgjgj',
//    'email' => 'Kk@gmail.com',
//    'first_name' => 'fhfjfh',
//    'last_name' => 'tjtuu',
//    'phone1' => '9567763727',
//    'terms' => true,
    [passengerDetails setValue:self.alternativePhoneTF.text forKey:@"phone2"];
    [passengerDetails setValue:self.commentTextView.text forKey:@"comments"];
    [passengerDetails setValue:self.emailTF.text forKey:@"email"];
    [passengerDetails setValue:self.firstNameTF.text forKey:@"first_name"];
    [passengerDetails setValue:self.lastNameTF.text forKey:@"last_name"];
    [passengerDetails setValue:self.phoneTF.text forKey:@"phone1"];
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
               
            }
        }
        
    } FailureBlock:^(NSError *error, int statusCode, id errorResponseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSInteger errorCode = (long)error.code;
        if(errorCode == 1024){
            [self showAlertWithTitle:APPNAME Message:NetworkUnavailableMessage WithCompletion:nil];
        }
        else{
            [self showAlertWithTitle:APPNAME Message:ConnectionTioServerFailedMessage WithCompletion:nil];
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
