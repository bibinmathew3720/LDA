//
//  NetworkHandler.m
//  NetworkHandler
//
//  Created by "" "" on 3/9/15.
//  Copyright (c) 2015 "". All rights reserved.
//

#import "AFNetworking.h"
#import "NetworkHandler.h"

#import "Reachability.h"
#import "RequestBodyGenerator.h"
#import "AFHTTPRequestOperationManager.h"

static NSString * const CLNetworkErrorMessage = @"No internet Access";
NSString * const kNetworkFailFailNotification = @"com.CL.NetworkHandler.fail";
NSString * const kNetworkSuccessNotification = @"com.CL.NetworkHandler.success";

@interface NetworkHandler()

@property (nonatomic, strong) NSURL * requestUrl;
@property (nonatomic, assign) MethodType methodType;
@property (nonatomic, assign) NSMutableDictionary * headerDictionary;
@property (nonatomic, strong) id bodyDictionary;
@property (nonatomic, strong) AFHTTPRequestOperation *requestOperation;

@end

@implementation NetworkHandler

+(NetworkHandler *) sharedHandler{
    static NetworkHandler *handler;
    static dispatch_once_t OnceToken;
    dispatch_once(&OnceToken, ^{
        handler = [[self alloc] init];
    });
    return handler;
}

+ (BOOL)checkNetworkTypeISWifi {
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    [reachability startNotifier];
    BOOL isWifi = NO;
    NetworkStatus status = [reachability currentReachabilityStatus];
    if(status == NotReachable) {
        isWifi = NO;
    }
    else if (status == ReachableViaWiFi) {
        isWifi = YES;
    }
    else if (status == ReachableViaWWAN) {
        isWifi = NO;
    }
    return isWifi;
}


#pragma mark- Network Check

+ (BOOL)networkUnavalible {
    Reachability *connectionMonitor = [Reachability reachabilityForInternetConnection];
    BOOL  hasInet = YES ;//= [connectionMonitor currentReachabilityStatus] != NotReachable;
    
    if ((connectionMonitor.isConnectionRequired) || (NotReachable == connectionMonitor.currentReachabilityStatus)) {
        hasInet = NO;
        
    } else if((ReachableViaWiFi == connectionMonitor.currentReachabilityStatus) || (ReachableViaWWAN == connectionMonitor.currentReachabilityStatus)){
        hasInet = YES;
    }
    return hasInet;
}

#pragma mark -

- (void)checkNetwrokAvailability {
    
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:self.requestUrl];
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status){
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi: {
                NSLog(@"SO REACHABLE");
                [operationQueue setSuspended:NO];
                [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkSuccessNotification object:nil];
                break;
            }
            case AFNetworkReachabilityStatusNotReachable:
            default: {
                NSLog(@"SO UNREACHABLE");
                [[NSNotificationCenter defaultCenter] postNotificationName:kNetworkFailFailNotification object:nil];
                [operationQueue setSuspended:YES];
                break;
            }
        }
    }];
    [manager.reachabilityManager startMonitoring];
}

#pragma mark - init Service Handler

- (id)initWithRequestUrl:(NSURL *) requestUrl withBody:(id) data withMethodType:(MethodType) method withHeaderFeild:(NSMutableDictionary *)headerDictionary {
    self = [super init];
    if(self) {
        [self checkNetwrokAvailability];
        self.requestUrl = requestUrl;
        self.bodyDictionary = data;
        self.methodType = method;
        self.headerDictionary =headerDictionary;
    }
    return self;
}


-(void)requestWithRequestUrl:(NSURL *)requestUrl withBody:(id) data withMethodType:(MethodType) method withHeaderFeild:(NSMutableDictionary *)headerDictionary{
    [self checkNetwrokAvailability];
    self.requestUrl = requestUrl;
    self.bodyDictionary = data;
    self.methodType = method;
    self.headerDictionary =headerDictionary;
}


#pragma mark - Statr Api Call

- (void)startServieRequestWithSucessBlockSuccessBlock:(void (^)( id responseObject,int statusCode))success FailureBlock:(void (^)( NSError *error,int statusCode,id errorResponseObject))failure {
    if (![NetworkHandler networkUnavalible]) {
        NSError * customError = [NSError errorWithDomain:CLNetworkErrorMessage code:1024 userInfo:nil];
        failure(customError,1024,nil);
        return;
    }
    [self cancellAllOperations];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:self.requestUrl];
    if( self.headerDictionary.count!=0)
        urlRequest.allHTTPHeaderFields = self.headerDictionary;

    [urlRequest setHTTPMethod:[self httpMethodForRequest:self.methodType]];
    if( [self.bodyDictionary isKindOfClass:[NSMutableDictionary class]] || [self.bodyDictionary isKindOfClass:[NSMutableArray class]]) {
         NSMutableDictionary *tempBodyDictionary = self.bodyDictionary;
        if(tempBodyDictionary.count !=0) {
            [urlRequest setHTTPBody:[[RequestBodyGenerator sharedBodyGenerator]requestBodyGeneratorWith:self.bodyDictionary]];
        }
    }
    else if( [self.bodyDictionary isKindOfClass:[NSString class]]){
        if(self.bodyDictionary!=nil)
            [urlRequest setHTTPBody:[self.bodyDictionary dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    }
    
    urlRequest.timeoutInterval = 20;
    self.requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        if([str isKindOfClass:[NSString class]]){
            NSLog(@"fdefejf wefwefh");
        }
        success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil],(int)operation.response.statusCode);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        id errorResponseObject;
        if(operation.responseObject != NULL) {
            errorResponseObject = [NSJSONSerialization JSONObjectWithData:operation.responseObject options:NSJSONReadingAllowFragments error:nil];
        } else {
            errorResponseObject = nil;
        }
        failure(error,(int)operation.response.statusCode,errorResponseObject);
    }];
    [self.requestOperation start];
}

#pragma mark - Image Download

-(void)startDownloadRequestSuccessBlock:(void (^)( id responseObject))success FailureBlock:(void (^)( NSString *errorDescription))failure  ProgressBlock:(void (^)( NSUInteger bytesWritten,long long totalBytesWritten, long long totalBytesExpectedToWrite))progress {
    if (![NetworkHandler networkUnavalible]) {
        failure(CLNetworkErrorMessage);
        return;
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:self.requestUrl];
    if( self.headerDictionary.count!=0)
        request.allHTTPHeaderFields = self.headerDictionary;
    
    [request setHTTPMethod:[self httpMethodForRequest:self.methodType]];
    NSMutableDictionary *tempBodyDictionary = self.bodyDictionary;
    if (tempBodyDictionary.count != 0) {
        [request setHTTPBody:[[RequestBodyGenerator sharedBodyGenerator]requestBodyGeneratorWith:self.bodyDictionary]];
    }
    self.requestOperation = [[AFHTTPRequestOperation alloc]initWithRequest:request];
    self.requestOperation.responseSerializer = [AFImageResponseSerializer serializer];
     self.requestOperation.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure([error localizedDescription]);
    }];
    [self.requestOperation start];
}

#pragma mark - File Upload

-(void)startUploadRequest:(NSString *)filename
              withBaseUrl:(NSString *)baseUrl
                 withData:(NSData *)Data
                 withType:(FileType)fileType
             SuccessBlock:(void (^)( id responseObject))success
            ProgressBlock:(void (^)( NSUInteger bytesWritten,long long totalBytesWritten, long long totalBytesExpectedToWrite))progress
             FailureBlock:(void (^)( NSString *errorDescription))failure {
    if (![NetworkHandler networkUnavalible]) {
        failure(CLNetworkErrorMessage);
        return;
    }
    AFHTTPRequestOperationManager *manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:[NSURL URLWithString:baseUrl]];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",@"text/plain", nil];
    if( self.headerDictionary.count!=0)
        manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    AFHTTPRequestOperation *op = [manager POST:@"fileUpload" parameters:self.bodyDictionary constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        [formData appendPartWithFileData:Data name:@"file" fileName:filename mimeType:[self mimeTypeOfFile:fileType]];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
        NSLog(@"Success: %@ ***** %@", operation.responseString, responseObject );
        NSLog(@"Success: %@",[[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding]);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure([error localizedDescription]);
        NSLog(@"Error: %@ ***** %@", operation.responseString, error);
    }];
    [self.requestOperation setUploadProgressBlock:^(NSUInteger bytesWritten, long long totalBytesWritten, long long totalBytesExpectedToWrite) {
        progress(bytesWritten,totalBytesWritten,totalBytesExpectedToWrite);
    }];
    [op start];
}


#pragma mark - Cancell All Operations

- (void)cancellAllOperations {
    [self.requestOperation cancel];
}

- (NSString *)httpMethodForRequest:(MethodType) method {
    NSString *type = nil;
    switch (method) {
        case HTTPMethodPOST:
            type = @"POST";
            break;
        case HTTPMethodGET:
            type = @"GET";
            break;
        case HTTPMethodPUT:
            type = @"DELETE";
            break;
            
        default:
            break;
    }
    return type;
}

-(NSString *)mimeTypeOfFile:(FileType)file{
    NSString *type = nil;
    switch (file) {
        case fileTypeJPGImage:
            type = @"image/jpeg";
            break;
        case fileTypePNGImage:
            type = @"image/png";
            break;
        case fileTypeDocument:
            type = @"application/msword";
            break;
        case fileTypePowerPoint:
            type = @"application/vnd.ms-powerpoint";
            break;
        case fileTypeHTML:
            type = @"text/html";
            break;
        case fileTypePDF:
            type = @"application/pdf";
            break;
        default:
            break;
    }
    return type;
}

-(NSString *)extensionOfFile:(FileType)file{
    NSString *extension = nil;
    switch (file) {
        case fileTypeJPGImage:
            extension = @".jpg";
            break;
        case fileTypePNGImage:
            extension = @".png";
            break;
        case fileTypeDocument:
            extension = @".doc";
            break;
        case fileTypeHTML:
            extension = @".html";
            break;
        case fileTypePDF:
            extension = @".pdf";
            break;
        case fileTypePowerPoint:
            extension = @".ppt";
            break;
        default:
            break;
    }
    return extension;
}

#pragma mark - NetworkHandler Observer

- (void)addNetworkHandlerobserver:(id)observer  {
    [[NSNotificationCenter defaultCenter] addObserver:observer selector:@selector(netWorkChanged:) name:kNetworkFailFailNotification object:nil];
}

- (void)removeNetworkHandlerObserver:(id)observer {
    [[NSNotificationCenter defaultCenter] removeObserver:observer name:kNetworkFailFailNotification object:nil];
}

- (void)netWorkChanged:(NSNotification *)notification {
    
}

- (void)startServieRequestForStringWithSucessBlockSuccessBlock:(void (^)( id responseObject,int statusCode))success FailureBlock:(void (^)( NSError *error,int statusCode,id errorResponseObject))failure {
    if (![NetworkHandler networkUnavalible]) {
        NSError * customError = [NSError errorWithDomain:CLNetworkErrorMessage code:1024 userInfo:nil];
        failure(customError,1024,nil);
        return;
    }
    [self cancellAllOperations];
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:self.requestUrl];
    if( self.headerDictionary.count!=0)
        urlRequest.allHTTPHeaderFields = self.headerDictionary;
    
    [urlRequest setHTTPMethod:[self httpMethodForRequest:self.methodType]];
    if( [self.bodyDictionary isKindOfClass:[NSMutableDictionary class]] || [self.bodyDictionary isKindOfClass:[NSMutableArray class]]) {
        NSMutableDictionary *tempBodyDictionary = self.bodyDictionary;
        if(tempBodyDictionary.count !=0) {
            [urlRequest setHTTPBody:[[RequestBodyGenerator sharedBodyGenerator]requestBodyGeneratorWith:self.bodyDictionary]];
        }
    }
    else if( [self.bodyDictionary isKindOfClass:[NSString class]]){
        if(self.bodyDictionary!=nil)
            [urlRequest setHTTPBody:[self.bodyDictionary dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES]];
    }
    
    urlRequest.timeoutInterval = 20;
    self.requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSString *str = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
        
        success(str,(int)operation.response.statusCode);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        id errorResponseObject;
        if(operation.responseObject != NULL) {
            errorResponseObject = [NSJSONSerialization JSONObjectWithData:operation.responseObject options:NSJSONReadingAllowFragments error:nil];
        } else {
            errorResponseObject = nil;
        }
        failure(error,(int)operation.response.statusCode,errorResponseObject);
    }];
    [self.requestOperation start];
}

#pragma mark - Statr Api Call

- (void)checkDataTransfer:(void (^)( id responseObject,int statusCode))success FailureBlock:(void (^)( NSError *error,int statusCode,id errorResponseObject))failure {
    if (![NetworkHandler networkUnavalible]) {
        NSError * customError = [NSError errorWithDomain:CLNetworkErrorMessage code:1024 userInfo:nil];
        failure(customError,1024,nil);
        return;
    }
    NSMutableURLRequest *urlRequest = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://www.google.in"]];
        [urlRequest setHTTPMethod:@"GET"];
    urlRequest.timeoutInterval = 10;
    self.requestOperation = [[AFHTTPRequestOperation alloc] initWithRequest:urlRequest];
    [self.requestOperation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        success([NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingAllowFragments error:nil],(int)operation.response.statusCode);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        id errorResponseObject;
        if(operation.responseObject != NULL) {
            errorResponseObject = [NSJSONSerialization JSONObjectWithData:operation.responseObject options:NSJSONReadingAllowFragments error:nil];
        } else {
            errorResponseObject = nil;
        }
        failure(error,(int)operation.response.statusCode,errorResponseObject);
    }];
    [self.requestOperation start];
}

@end
