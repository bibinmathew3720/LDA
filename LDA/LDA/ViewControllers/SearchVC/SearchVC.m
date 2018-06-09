//
//  SearchVC.m
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "SearchVC.h"

@interface SearchVC ()
@property (nonatomic, strong) NSArray *airportArray;
@property (nonatomic, strong) NSArray *airportSearchArray;
@end

@implementation SearchVC

-(void)initView{
    [super initView];
    [self callingSearchApiWithKeyword:@""];
}

#pragma mark - Button Actions

- (IBAction)leftBarButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)callingSearchApiWithKeyword:(NSString *)searchKeyword{
    NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
    [searchDictionary setValue:searchKeyword forKey:@"search_key"];
    NSURL *searchUrl = [[UrlGenerator sharedHandler] urlForRequestType:LDAURLTYPESearch withURLParameter:nil];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NetworkHandler *networkHandler = [[NetworkHandler alloc] initWithRequestUrl:searchUrl withBody:searchDictionary withMethodType:HTTPMethodGET withHeaderFeild:nil];
    [networkHandler startServieRequestWithSucessBlockSuccessBlock:^(id responseObject, int statusCode) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if([[responseObject valueForKey:@"status_code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
                self.airportArray = [responseObject valueForKey:@"data"];
            }
        }
        
    } FailureBlock:^(NSError *error, int statusCode, id errorResponseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSInteger errorCode = (long)error.code;
        NSString *errorMessage = @"";
        if(errorCode == 1024){
            [self showAlertWithTitle:APPNAME Message:NetworkUnavailableMessage WithCompletion:nil];
        }
        else{
             [self showAlertWithTitle:APPNAME Message:ConnectionTioServerFailedMessage WithCompletion:nil];
        }
    }];
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
