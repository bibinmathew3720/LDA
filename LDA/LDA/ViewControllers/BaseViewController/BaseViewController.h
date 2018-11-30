//
//  BaseViewController.h
//  LDA
//
//  Created by "" on 5/30/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MBProgressHUD.h"
#import "UIView+CLAdditions.h"
#import "NSString+Extension.h"

#import "NetworkHandler.h"
#import "UrlGenerator.h"
#import "ResponseHandler.h"

@interface BaseViewController : UIViewController
@property(nonatomic,strong) UIBarButtonItem *leftBarButton;

- (void) initView;
- (void) showLeftBarButton;
-(void)showAlertWithTitle:(NSString *)titleString Message:(NSString *)alertMessage WithCompletion:(void(^)(void))okCompletion;
- (NSString *)convertDate:(NSDate *)currentDate toFormatedString:(NSString *)formateString withTimeZone:(NSTimeZone *)timezone;
-(NSDate *)convertStringToDate:(NSString *)dateString;
-(BOOL)isArabicLanguage;
@end
