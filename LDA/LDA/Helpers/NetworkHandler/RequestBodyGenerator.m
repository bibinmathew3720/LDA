//
//  RequestBodyGenerator.m
//  NetworkHandler
//
//  Created by Vaisakh krishnan on 3/9/15.
//  Copyright (c) 2015 Pumex. All rights reserved.
//

#import "RequestBodyGenerator.h"

@implementation RequestBodyGenerator

+(RequestBodyGenerator *) sharedBodyGenerator{
    static RequestBodyGenerator *sharedBodyGenerator;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        sharedBodyGenerator = [[self alloc] init];
    });
    return sharedBodyGenerator;
}

#pragma mark - Request body Generator

- (NSData *)requestBodyGeneratorWith:(NSMutableDictionary *)contentDictionary {
    NSString * string = nil;
    if ([NSJSONSerialization isValidJSONObject:contentDictionary]) {
        string = [[NSString alloc] initWithData:[NSJSONSerialization dataWithJSONObject:contentDictionary
                                                                                options:NSJSONWritingPrettyPrinted error:nil] encoding:NSUTF8StringEncoding];
    }
    NSLog(@"%@",string);
    return [string dataUsingEncoding:NSUTF8StringEncoding];
}


@end

@implementation HeaderBodyGenerator


+(HeaderBodyGenerator *) sharedHeaderGenerator {
    static HeaderBodyGenerator *sharedBodyGenerator;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        sharedBodyGenerator = [[self alloc] init];
    });
    return sharedBodyGenerator;
}

- (NSMutableDictionary *)headerBody {
    NSMutableDictionary * headerDictionary = [[NSMutableDictionary alloc]init];
    //[headerDictionary setValue:@"Accept" forKey:@"application/json"];
    [headerDictionary setValue:@"application/json" forKey:@"Content-Type"];
    return headerDictionary;
}

- (NSMutableDictionary *)headerWithourAccessToken {
    NSMutableDictionary * headerDictionary = [[NSMutableDictionary alloc]init];
    [headerDictionary setValue:@"Accept" forKey:@"application/json"];
    //[headerDictionary setValue:@"text/plain" forKey:@"Content-Type"];
    return headerDictionary;
}


@end
