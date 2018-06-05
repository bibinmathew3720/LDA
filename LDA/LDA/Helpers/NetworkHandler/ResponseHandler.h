//
//  ResponseHandler.h
//  uQuote
//
//  Created by Vaisakh Krishnan on 29/12/15.
//  Copyright © 2015 AutoLink. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef NS_ENUM(NSInteger, VERANORESPONSETYPE ){
    UQURESPONSETYPESubmitUserProfile,
    UQURESPONSETYPEGetUserDetails,
    UQURESPONSETYPELogin,
    UQURESPONSETYPERefreshToken,
};

@interface ResponseHandler : NSObject

+(ResponseHandler *) sharedHandler;
- (BOOL)processResponse:(VERANORESPONSETYPE )responseType withStatusCode:(int)statusCode;
- (NSString *)processError:(VERANORESPONSETYPE )responseType withStatusCode:(int)statusCode withError:(NSError *)error withErrorObject:(id)errorObject;

@end
