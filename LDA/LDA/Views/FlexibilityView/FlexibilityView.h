//
//  FlexibilityView.h
//  LDA
//
//  Created by "" on 6/8/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FlexibiltyViewDelegate;
@interface FlexibilityView : UIView
@property (nonatomic, assign) id <FlexibiltyViewDelegate>flexibilityDelegate;
@end
@protocol FlexibiltyViewDelegate <NSObject>
-(void)selectedFlexibilityItem:(id)flexibilityItem;
@end
