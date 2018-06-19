//
//  BaseViewController.m
//  LDA
//
//  Created by Bibin Mathew on 5/30/18.
//  Copyright © 2018 lda. All rights reserved.
//

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
   navigationBarAppearence.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIFont fontWithName:@"Roboto-Bold" size:18],NSFontAttributeName ,[UIColor whiteColor], NSForegroundColorAttributeName, nil];
    navigationBarAppearence.barTintColor = LDAAPPCOMMONBLUECOLOR;
    [[UINavigationBar appearance] setBarStyle:UIBarStyleDefault];
    [UINavigationBar appearance].tintColor = [UIColor whiteColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)showAlertWithTitle:(NSString *)titleString Message:(NSString *)alertMessage WithCompletion:(void(^)(void))okCompletion{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:titleString message:alertMessage preferredStyle:UIAlertControllerStyleAlert];
    NSString *okString = NSLocalizedString(@"OK", @"OK");
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:okString style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        if(okCompletion !=nil)
            okCompletion();
    }];
    [alert addAction:okAction];
    dispatch_async(dispatch_get_main_queue(), ^{
         [self presentViewController:alert animated:YES completion:nil];
    });
}

#pragma mark - Show Left Bar Button

- (void)showLeftBarButton {
    self.leftBarButton = [[UIBarButtonItem alloc]initWithImage:[[UIImage imageNamed:@"backArrow"]imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]  style:UIBarButtonItemStylePlain target:self action:@selector(leftButtonAction:)];
    self.navigationItem.leftBarButtonItem =  self.leftBarButton;
}

-(void)leftButtonAction:(UIBarButtonItem *)barButton{
    [self.navigationController popViewControllerAnimated:YES];
}

- (NSString *)convertDate:(NSDate *)currentDate toFormatedString:(NSString *)formateString withTimeZone:(NSTimeZone *)timezone {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:timezone];
    [dateFormatter setDateFormat:formateString];
    return [dateFormatter stringFromDate:currentDate];
}

-(NSDate *)convertStringToDate:(NSString *)dateString{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDate *date = [dateFormat dateFromString:dateString];
    return date;
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
