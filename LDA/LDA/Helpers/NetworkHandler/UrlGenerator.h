//
//  UrlGenerator.h
//  uQuote
//
//  Created by "" "" on 29/12/15.
//  Copyright © 2015 AutoLink. All rights reserved.
//

#import <Foundation/Foundation.h>


//static NSString *LDABaseUrl =@"http://34.215.160.196/SmartInverter/index.php?"; //Test Server
static NSString *LDABaseUrl = @"http://app.luxurydiscountair.com/"; // Production Server

static NSString *LDASearchUrl = @"v1/airport?search_key=";
static NSString *LDASaveTripDetails = @"v1/trip";
static NSString *LDATermsAndConditions = @"https://luxurydiscountair.com/about/terms";

typedef NS_ENUM(NSInteger, LDAURLType ){
    LDAURLTYPESearch = 1,
    LDAURLTYPESubmitTripDetails = 2,
    LDAURLTYPETermsAndConditions = 3,
    
};

@interface UrlGenerator : NSObject

+(UrlGenerator *) sharedHandler;
- (NSURL *)urlForRequestType:(LDAURLType) type withURLParameter:(NSString *)urlParameter;

@end
