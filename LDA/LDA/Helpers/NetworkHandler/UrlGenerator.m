//
//  UrlGenerator.m
//  uQuote
//
//  Created by Vaisakh Krishnan on 29/12/15.
//  Copyright © 2015 AutoLink. All rights reserved.
//

#import "UrlGenerator.h"

@implementation UrlGenerator

+(UrlGenerator *) sharedHandler {
    static UrlGenerator *handler;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        handler = [[self alloc] init];
    });
    return handler;
}

- (NSURL *)urlForRequestType:(VERANOURLTYPE) type withURLParameter:(NSString *)urlParameter {
    NSString *baseURL = VERANOBaseUrl;
    NSString *appendingUrl;
    switch (type) {
        case VERANOURLTYPESubmitProfile:
            appendingUrl = urlParameter;
            break;
        case VERANOURLTYPEUserDetails:
            appendingUrl = VERANUserDetailUrl;
            break;
        case VERANOURLTYPEUserLogin:
            appendingUrl = VERANOLoginUrl;
            break;
        case VERANOURLTYPERefreshToken:
            appendingUrl = [NSString stringWithFormat:@"%@%@",VERANORefreshToken,urlParameter];
            break;
        case VERANOURLTYPEForgotPassword:
            appendingUrl = VERANOForgotPassword;
            break;
        case VERANOURLTYPEAddProduct:
            appendingUrl = VERANOSubmitProductProfile;
            break;
        case VERANOURLTYPEGetMyProducts:
            appendingUrl = VERANOGetMyProducts;
            break;
        case VERANOURLTYPEDeleteProduct:
            appendingUrl = VERANODeleteProduct;
            break;
        case VERANOURLTYPEUpdateSettingsFromMobile:
            appendingUrl = VERANOUpdateSettingsFromMobile;
            break;
        case VERANOURLTYPEGetVeranoSettings:
            appendingUrl = VERANOGetVeranoSettings;
            break;
        case VERANOURLTYPEPostVeranoComplaints:
            appendingUrl = VERANOPostVeranoComplaints;
            break;
        case VERANOURLTYPEGetUSerFeedBack:
            appendingUrl = VERANOGetUserFeedBack;
            break;
        case VERANOURLTYPEGetModel:
            appendingUrl = VERANOGetModel;
            break;
        case VERANOURLTYPEInstallationRequest:
            appendingUrl = VERANOInstallationRequest;
            break;
        case  VERANOURLTYPEConnectProduct :
            appendingUrl = VERANOConnectProduct;
            break;
        case  VERANOURLTYPEUpdateProfile :
            appendingUrl = VERANOUpdateProfile;
            break;
        case VERANOURLTYPELogout:
            appendingUrl = VERANOLogoutUrl;
            break;
        case VERANOURLTYPESubmitInverterSettings:
            appendingUrl = VERANOSubmitInverterReadings;
            break;
        case INVERTERURLTYPEGETPRODUCTINFO:
            appendingUrl = InverterGetProductInfo;;
            break;
        case INVERTERURLTYPESUBMITMACID:
            appendingUrl = InverterSubmitMacId;;
            break;
        case VERANOURLTYPEDistricList:
            appendingUrl = [NSString stringWithFormat:@"%@%@",DistricListUrl,urlParameter];
            return [NSURL URLWithString:[appendingUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
            break;
        case VERANOREGISTERDEVICETOKEN:
            appendingUrl = registerDevicetoken;;
            break;
        case VERANOREGISTERComplaintStatus:
            appendingUrl = complaintStatus;;
            break;
        case VERANOREGISTERGetDeviceSettings:
            appendingUrl = getDeviceSettings;;
            break;
        case VERANOURLTYPEAddFanProduct:
            appendingUrl = VERANOSubmitFanProductProfile;
            break;
        case IMAGINAURLTYPEGetFanProductInfo:
            appendingUrl = getProductInfoUrlForFan;
            break;
        default:
            break;
    }
    if([appendingUrl rangeOfString:@"%"].location != NSNotFound) {
        return [NSURL URLWithString:[baseURL stringByAppendingString:appendingUrl]] ;
    }
    return [NSURL URLWithString:[[baseURL stringByAppendingString:appendingUrl] stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
}

@end
