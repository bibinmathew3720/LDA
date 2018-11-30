//
//  SearchVC.m
//  LDA
//
//  Created by "" on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "SearchVC.h"
#import "SearchTVC.h"

@interface SearchVC ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *airportTableView;
@property (nonatomic, strong) NSArray *airportArray;
@property (nonatomic, strong) NSArray *airportSearchArray;
@end

@implementation SearchVC

-(void)initView{
    [super initView];
    [self initilisation];
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [self callingSearchApiWithKeyword:@""];
}

-(void)initilisation{
    self.title = NSLocalizedString(@"Search", @"Search");
    if(self.searchType == searchTypeFrom){
        self.searchBar.placeholder = NSLocalizedString(@"From where?", @"From where?");
    }
    else{
        self.searchBar.placeholder = NSLocalizedString(@"To where?", @"To where?");
    }
}

#pragma mark - Button Actions

- (IBAction)leftBarButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)callingSearchApiWithKeyword:(NSString *)searchKeyword{
    //NSMutableDictionary *searchDictionary = [[NSMutableDictionary alloc] init];
   // NSString *tempString = [NSString stringWithFormat:@"search_key=%@",searchKeyword];
    //[searchDictionary setValue:searchKeyword forKey:@"search_key"];
    NSURL *searchUrl = [[UrlGenerator sharedHandler] urlForRequestType:LDAURLTYPESearch withURLParameter:searchKeyword];
    NetworkHandler *networkHandler = [[NetworkHandler alloc] initWithRequestUrl:searchUrl withBody:nil withMethodType:HTTPMethodGET withHeaderFeild:nil];
    [networkHandler startServieRequestWithSucessBlockSuccessBlock:^(id responseObject, int statusCode) {
        NSLog(@"Response Object:%@",responseObject);
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        });
        if([responseObject isKindOfClass:[NSDictionary class]]){
            if([[responseObject valueForKey:@"status_code"] isEqualToNumber:[NSNumber numberWithInt:200]]){
                self.airportArray = [responseObject valueForKey:@"data"];
                [self.airportTableView reloadData];
            }
        }
        
    } FailureBlock:^(NSError *error, int statusCode, id errorResponseObject) {
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        NSInteger errorCode = (long)error.code;
        NSString *errorMessage = @"";
        if(errorCode == 1024){
            [self showAlertWithTitle:NSLocalizedString(@"Failed", @"Failed") Message:NSLocalizedString(@"NetworkNotAvail", @"Network not available") WithCompletion:nil];
        }
        else{
             [self showAlertWithTitle:NSLocalizedString(@"Failed", @"Failed") Message:NSLocalizedString(@"SubmissionFailedMessage", @"SubmissionFailedMessage") WithCompletion:nil];
        }
    }];
}

#pragma mark - UITable View Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.airportArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    SearchTVC *searchTVC = [tableView dequeueReusableCellWithIdentifier:@"searchCell"];
    searchTVC.locationDetails = [self.airportArray objectAtIndex:indexPath.row];
    return searchTVC;
}

//-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 10;
//}
//
//-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *headerView = [UIView new];
//    return headerView;
//}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *codeString = [[self.airportArray objectAtIndex:indexPath.row] valueForKey:@"code"];
    if (self.searchType == searchTypeFrom){
        if([self.destCode isEqualToString:codeString]){
            [self showAlertForSameSourceAndDestination];
        }
        else{
            [self moveToHomePageWithLocationDetails:[self.airportArray objectAtIndex:indexPath.row]];
        }
    }
    else if (self.searchType == searchTypeTo){
        if([self.sourceCode isEqualToString:codeString]){
            [self showAlertForSameSourceAndDestination];
        }
        else{
            [self moveToHomePageWithLocationDetails:[self.airportArray objectAtIndex:indexPath.row]];
        }
    }
}
-(void)showAlertForSameSourceAndDestination{
    [self showAlertWithTitle:NSLocalizedString(@"Warning", @"Warning") Message:NSLocalizedString(@"SourceAndDestSame", @"The source and destination can not be alike") WithCompletion:^{
        
    }];
}

-(void)moveToHomePageWithLocationDetails:(id)locationDetails{
    if(self.searchDelegate && [self.searchDelegate respondsToSelector:@selector(selectedLocationWithDetails:withSearchType:)]){
        [self.searchDelegate selectedLocationWithDetails:locationDetails withSearchType:self.searchType];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Search Bar Delegates

-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    [self callingSearchApiWithKeyword:searchText];
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
