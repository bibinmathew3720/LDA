//
//  PassengerDetailsVC.m
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//
#import "PassengerDetailsVC.h"

@interface PassengerDetailsVC ()
@property (weak, nonatomic) IBOutlet UIView *firstNameView;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTF;

@end

@implementation PassengerDetailsVC

-(void)initView{
    [super initView];
    [self initialisation];
}

-(void)initialisation{
    [self settingBorderToView:self.firstNameView];
}

-(void)settingBorderToView:(UIView *)view{
    view.layer.borderColor = LDAAPPCOMMONBLUECOLOR.CGColor;
    view.layer.borderWidth = 1;
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
