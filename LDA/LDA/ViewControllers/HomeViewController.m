//
//  HomeViewController.m
//  LDA
//
//  Created by Bibin Mathew on 5/29/18.
//  Copyright © 2018 lda. All rights reserved.
//
#import "OneWayRoundView.h"

#import "HomeViewController.h"

@interface HomeViewController ()
@property (nonatomic,strong) OneWayRoundView *onewayRoundView;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentControl;
@end

@implementation HomeViewController

-(void)initView{
    [super initView];
    [self initialisation];
    [self addingOneWayView];
    
}

-(void)addingOneWayView{
    self.onewayRoundView = [[[NSBundle mainBundle] loadNibNamed:@"OneWayRoundView" owner:self options:nil] objectAtIndex:0];
    self.onewayRoundView.frame = CGRectMake(0, self.segmentControl.bottom+10, self.view.frame.size.width, self.view.frame.size.height-self.segmentControl.bottom-10);
    [self.view addSubview:self.onewayRoundView];
}

-(void)initialisation{
    self.title = @"Home";
}

- (IBAction)segmentControlAction:(UISegmentedControl *)sender {
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
