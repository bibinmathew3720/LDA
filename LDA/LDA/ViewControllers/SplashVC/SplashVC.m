//
//  SplashVC.m
//  LDA
//
//  Created by Bibin Mathew on 6/10/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "SplashVC.h"

@interface SplashVC ()

@end

@implementation SplashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _splashImageView.animationImages = [NSArray arrayWithObjects:
                                         [UIImage imageNamed:@"LargeSize_1.gif"],
                                         [UIImage imageNamed:@"LargeSize_1.gif"], nil];
    _splashImageView.animationDuration = 1.0f;
    _splashImageView.animationRepeatCount = 0;
    [_splashImageView startAnimating];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
