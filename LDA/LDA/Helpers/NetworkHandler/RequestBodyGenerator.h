//
//  RequestBodyGenerator.h
//  NetworkHandler
//
//  Created by "" "" on 3/9/15.
//  Copyright (c) 2015 "". All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RequestBodyGenerator : NSObject

+(RequestBodyGenerator *) sharedBodyGenerator;
- (NSData *)requestBodyGeneratorWith:(NSMutableDictionary *)contentDictionary;

@end

@interface HeaderBodyGenerator : NSObject

- (NSMutableDictionary *)headerBody;
- (NSMutableDictionary *)headerWithourAccessToken;
+(HeaderBodyGenerator *) sharedHeaderGenerator;

@end
