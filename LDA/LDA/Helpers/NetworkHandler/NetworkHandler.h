//
//  NetworkHandler.h
//  NetworkHandler
//
//  Created by "" "" on 3/9/15.
//  Copyright (c) 2015 "". All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum  {
    HTTPMethodGET,
    HTTPMethodPOST,
    HTTPMethodPUT,
}MethodType;

typedef enum{
    fileTypeJPGImage,
    fileTypePNGImage,
    fileTypeDocument,
    fileTypePowerPoint,
    fileTypeHTML,
    fileTypePDF
}FileType;

extern NSString * const kNetworkFailFailNotification;


@interface NetworkHandler : NSObject

+(BOOL)networkUnavalible;
+(NetworkHandler *) sharedHandler;
+ (BOOL)checkNetworkTypeISWifi;
- (void)cancellAllOperations ;
- (void)addNetworkHandlerobserver:(id)observer;
- (void)removeNetworkHandlerObserver:(id)observer;
- (void)checkDataTransfer:(void (^)( id responseObject,int statusCode))success FailureBlock:(void (^)( NSError *error,int statusCode,id errorResponseObject))failure;
- (id)initWithRequestUrl:(NSURL *) requestUrl withBody:(id) data withMethodType:(MethodType) method withHeaderFeild:(NSMutableDictionary *)headerDictionary;
-(void)requestWithRequestUrl:(NSURL *)requestUrl withBody:(id) data withMethodType:(MethodType) method withHeaderFeild:(NSMutableDictionary *)headerDictionary;
- (void)startServieRequestWithSucessBlockSuccessBlock:(void (^)( id responseObject,int statusCode))success FailureBlock:(void (^)( NSError *error,int statusCode,id errorResponseObject))failure;
- (void)startServieRequestForStringWithSucessBlockSuccessBlock:(void (^)( id responseObject,int statusCode))success FailureBlock:(void (^)( NSError *error,int statusCode,id errorResponseObject))failure;
-(void)startUploadRequest:(NSString *)filename
              withBaseUrl:(NSString *)baseUrl
                 withData:(NSData *)Data
                 withType:(FileType)fileType
             SuccessBlock:(void (^)( id responseObject))success
            ProgressBlock:(void (^)( NSUInteger bytesWritten,long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
             FailureBlock:(void (^)( NSString *errorDescription))failure;
-(void)startDownloadRequestSuccessBlock:(void (^)( id responseObject))success FailureBlock:(void (^)( NSString *errorDescription))failure  ProgressBlock:(void (^)( NSUInteger bytesWritten,long long totalBytesWritten, long long totalBytesExpectedToWrite))progress;

@end
