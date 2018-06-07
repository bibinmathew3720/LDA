//
//  BaseViewController.h
//  LDA
//
//  Created by Bibin Mathew on 5/30/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "MBProgressHUD.h"
#import "UIView+CLAdditions.h"
#import "NSString+Extension.h"


@interface BaseViewController : UIViewController
@property(nonatomic,strong) UIBarButtonItem *leftBarButton;

- (void) initView;
- (void) showLeftBarButton;
-(void)showAlertWithTitle:(NSString *)titleString Message:(NSString *)alertMessage WithCompletion:(void(^)(void))okCompletion;
@end
