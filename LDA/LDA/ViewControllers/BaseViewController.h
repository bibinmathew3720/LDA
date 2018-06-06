//
//  BaseViewController.h
//  LDA
//
//  Created by Bibin Mathew on 5/30/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIView+CLAdditions.h"
#import "NSString+Extension.h"

@interface BaseViewController : UIViewController
-(void)initView;
-(void)showAlertWithTitle:(NSString *)titleString Message:(NSString *)alertMessage WithCompletion:(void(^)(void))okCompletion;
@end
