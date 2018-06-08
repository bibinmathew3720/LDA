//
//  MultipleStopView.h
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MultipleStopViewDelegate;
@interface MultipleStopView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *multipleStopTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *passengersCountLabel;
@property (nonatomic, assign) id <MultipleStopViewDelegate>multipleViewDelegate;
@property (weak, nonatomic) IBOutlet UITextField *classTF;
@property (weak, nonatomic) IBOutlet UITextField *passengersTF;
@end
@protocol MultipleStopViewDelegate<NSObject>
-(void)classButtonActionDelegateFromMultipleStopWithTF:(UITextField *)textField;
-(void)passengsersButtonActionDelegateMultipleStopWithTF:(UITextField *)textField;
@end
