//
//  ResponseHandler.m
//  uQuote
//
//  Created by Vaisakh Krishnan on 29/12/15.
//  Copyright © 2015 AutoLink. All rights reserved.
//

#import "ResponseHandler.h"

static NSString *VeranoNOInternet = @"Please check your network.";

@implementation ResponseHandler

+(ResponseHandler *) sharedHandler {
    static ResponseHandler *handler;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        handler = [[self alloc] init];
    });
    return handler;
}

#pragma mark - Process Response

- (BOOL)processResponse:(VERANORESPONSETYPE )responseType withStatusCode:(int)statusCode {
    BOOL isSuccess = false;
    switch (statusCode) {
        case 200:
            isSuccess = true;
            break;
            
        default:
            break;
    }
    return isSuccess;
}

#pragma mark - Process error

- (NSString *)processError:(VERANORESPONSETYPE )responseType withStatusCode:(int)statusCode withError:(NSError *)error withErrorObject:(id)errorObject {
    NSString * errorMessage = NSLocalizedString(@"CheckNetworkConnection", @"Unable to process the action.\nPlease check your Network conection");
    
    switch (statusCode) {
        case 1024:
            errorMessage = VeranoNOInternet;
            break;
        case 0:
            
            break;
        case 500:
            
            break;
        case 501:
            if(responseType == UQURESPONSETYPELogin) {
                errorMessage = [errorObject objectForKey:@"statusMessage"];
            }
            break;
        case 403:
            if(responseType == UQURESPONSETYPERefreshToken) {
                errorMessage = [errorObject objectForKey:@"error_description"];
            }
            break;
        case 409:
            errorMessage = [errorObject objectForKey:@"statusMessage"];
            break;
        case 400:
            if(errorObject!= nil) {
                errorMessage = [errorObject objectForKey:@"statusMessage"];
            }
            break;
        case 404:
            errorMessage = NSLocalizedString(@"UnableToConnectServerAlert",@"Unable to connect the server,please try again later");
            break;
        default:
            errorMessage = [error localizedDescription];
            break;
    }
    return errorMessage;
}

@end
