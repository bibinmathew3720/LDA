//
//  WebViewVC.m
//  LDA
//
//  Created by Bibin Mathew on 6/7/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "WebViewVC.h"

@interface WebViewVC ()<UIWebViewDelegate>

@end

@implementation WebViewVC

-(void)initView{
    [super initView];
    [self initialisation];
}

-(void)initialisation{
    self.title = @"Terms and Conditions";
    NSString *termsAndConditionsString  = @"https://luxurydiscountair.com/about/terms";
    NSURL *websiteUrl = [NSURL URLWithString:termsAndConditionsString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:websiteUrl];
    [self.webView loadRequest:urlRequest];
    [self showLeftBarButton];
}

#pragma mark - Web view Delegates

-(void)webViewDidStartLoad:(UIWebView *)webView{
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    
}

-(void)webViewDidFinishLoad:(UIWebView *)webView{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
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
