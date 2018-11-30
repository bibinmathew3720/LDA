//
//  SplashVC.m
//  LDA
//
//  Created by "" on 6/10/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "SplashVC.h"
#import "FLAnimatedImage.h"

#define SplashImageWidth 217
#define SplashImageheight 175
#define GifImageName @"splash"

@interface SplashVC ()

@end

@implementation SplashVC

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *filePath = [[NSBundle mainBundle] pathForResource: GifImageName ofType: @"gif"];
    NSData *gifData = [NSData dataWithContentsOfFile: filePath];
    FLAnimatedImage *image = [FLAnimatedImage animatedImageWithGIFData:gifData];
    FLAnimatedImageView *imageView = [[FLAnimatedImageView alloc] init];
    imageView.animatedImage = image;
    imageView.frame = CGRectMake(self.view.frame.size.width/2 - SplashImageWidth/2 , self.view.frame.size.height/2 - SplashImageheight/2, SplashImageWidth , SplashImageheight);
    [self.view addSubview:imageView];
    self.navigationController.navigationBar.hidden = YES;
    [self addingSplashTimer];
}

-(void)addingSplashTimer{
    NSTimer *splashTimer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(splashTimerAction:) userInfo:nil repeats:NO];
}

-(void)splashTimerAction:(NSTimer *)timer{
    [timer invalidate];
    [self performSegueWithIdentifier:@"splashToHome" sender:nil];
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
