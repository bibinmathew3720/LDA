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

- (NSURL *)urlForRequestType:(LDAURLType) type withURLParameter:(NSString *)urlParameter {
    NSString *baseURL = LDABaseUrl;
    NSString *appendingUrl;
    switch (type) {
        case LDAURLTYPESearch:
            appendingUrl = LDASearchUrl;
            break;
        case LDAURLTYPESubmitTripDetails:
            appendingUrl = LDASaveTripDetails;
            break;
        case LDAURLTYPETermsAndConditions:
            return [NSURL URLWithString:LDATermsAndConditions];
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
