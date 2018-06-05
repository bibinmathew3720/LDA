//
//  UrlGenerator.h
//  uQuote
//
//  Created by Vaisakh Krishnan on 29/12/15.
//  Copyright © 2015 AutoLink. All rights reserved.
//

#import <Foundation/Foundation.h>


//static NSString *VERANOBaseUrl =@"http://34.215.160.196/SmartInverter/index.php?"; //Test Server
static NSString *VERANOBaseUrl =@"http://vguard.co/mobileapps/verano/index.php?"; // Production Server

static NSString *VERANOSubmitUrl = @"submitprofilenew";//@"submitprofile";
static NSString *VERANOUpdateProfile = @"updateProfile";
static NSString *VERANOLoginUrl = @"/Users/login";
static NSString *VERANUserDetailUrl = @"Users/me";//@"me";
static NSString *VERANORefreshToken = @"token?refresh_token=";
static NSString *VERANOForgotPassword = @"forgotPassword";
static NSString *VERANOGetUserFeedBack =@"getUserFeedback";
static NSString *VERANOSubmitProductProfile = @"submitProductProfile";//@"submitProductProfilenew";
static NSString *VERANOSubmitFanProductProfile = @"smartFan/submitProductProfileTest";
static NSString *VERANOGetMyProducts = @"getMyProducts";
static NSString *VERANODeleteProduct = @"deleteProduct";
static NSString *VERANOUpdateSettingsFromMobile = @"updateSettingsFromMobile";
static NSString *VERANOGetVeranoSettings = @"getVeranoSettings";
static NSString *VERANOPostVeranoComplaints = @"Users/submitComplaint";
static NSString *VERANOGetModel = @"productmodel";
static NSString *VERANOInstallationRequest = @"installationRequest";
static NSString *VERANOConnectProduct = @"connectproduct";
static NSString *VERANOCustomerCareUrl = @"http://www.vguard.in/home/customer-care";
static NSString *VERANOLogoutUrl = @"logout";
static NSString *VERANOSubmitInverterReadings = @"submitInverterReadings";
static NSString *InverterGetProductInfo = @"getProductInfo";
static NSString *InverterSubmitMacId = @"submitMacId";
static NSString *registerDevicetoken = @"registerDevice";
static NSString *getDeviceSettings = @"getDeviceSettings";
static NSString *complaintStatus = @"complaintStatus";
static NSString *DistricListUrl = @"http://www.vguard.in/get-district-list?state=";
static NSString *VERANOPrivacyPolicyUrl = @"http://vguard.co/mobileapps/smart/privacy_policy.html";

//Urls for Fan

static NSString *getProductInfoUrlForFan = @"smartFan/getProductInfo";

typedef NS_ENUM(NSInteger, VERANOURLTYPE ){
    VERANOURLTYPESubmitProfile = 1,
    VERANOURLTYPEUserLogin = 2,
    VERANOURLTYPEUserDetails = 3,
    VERANOURLTYPERefreshToken = 4,
    VERANOURLTYPEForgotPassword = 5,
    VERANOURLTYPEAddProduct = 6,
    VERANOURLTYPEGetMyProducts = 7,
    VERANOURLTYPEDeleteProduct = 8,
    VERANOURLTYPEUpdateSettingsFromMobile =9,
    VERANOURLTYPEGetVeranoSettings = 10,
    VERANOURLTYPEPostVeranoComplaints = 11,
    VERANOURLTYPEGetUSerFeedBack = 12,
    VERANOURLTYPEGetModel = 13,
    VERANOURLTYPEInstallationRequest = 14,
    VERANOURLTYPEConnectProduct = 15,
    VERANOURLTYPEUpdateProfile = 16,
    VERANOURLTYPELogout = 17,
    VERANOURLTYPESubmitInverterSettings = 18,
    INVERTERURLTYPEGETPRODUCTINFO = 19,
    INVERTERURLTYPESUBMITMACID = 20,
    VERANOURLTYPEDistricList = 21,
    VERANOREGISTERDEVICETOKEN = 22,
    VERANOREGISTERComplaintStatus = 23,
    VERANOREGISTERGetDeviceSettings = 24,
    VERANOURLTYPEAddFanProduct = 25,
    
    IMAGINAURLTYPEGetFanProductInfo = 26,
    
};

@interface UrlGenerator : NSObject

+(UrlGenerator *) sharedHandler;
- (NSURL *)urlForRequestType:(VERANOURLTYPE) type withURLParameter:(NSString *)urlParameter;

@end
