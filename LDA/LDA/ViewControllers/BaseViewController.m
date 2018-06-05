//
//  BaseViewController.m
//  LDA
//
//  Created by Bibin Mathew on 5/30/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "Constants.h"
#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     [self initView];
    // Do any additional setup after loading the view.
}

-(void)initView{
    [self initNavigationBarAppearence];
}

- (void)initNavigationBarAppearence {
    UINavigationBar * navigationBarAppearence = [UINavigationBar appearance];
    navigationBarAppearence.translucent = NO;
   //navigationBarAppearence.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:fontNormal size:18],NSFontAttributeName ,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    navigationBarAppearence.barTintColor = LDAAPPCOMMONBLUECOLOR;
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
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
