//
//  SearchVC.h
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
typedef enum {
    searchTypeFrom = 0,
    searchTypeTo = 1,
}SearchType;

@protocol SearchVCDelegate;
@interface SearchVC : BaseViewController
@property (nonatomic, assign) id <SearchVCDelegate>searchDelegate;
@property (nonatomic, assign) SearchType searchType;
@end
@protocol SearchVCDelegate<NSObject>
-(void)selectedLocationWithDetails:(id)locationDetails withSearchType:(SearchType)searchType;
@end
