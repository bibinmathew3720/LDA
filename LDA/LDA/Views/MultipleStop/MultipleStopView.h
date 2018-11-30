//
//  MultipleStopView.h
//  LDA
//
//  Created by "" on 6/6/18.
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
@property (weak, nonatomic) IBOutlet UIButton *removeButton;
@property (weak, nonatomic) IBOutlet UIButton *addButton;
@property (nonatomic, strong) NSArray *tripArray;
@end
@protocol MultipleStopViewDelegate<NSObject>
-(void)classButtonActionDelegateFromMultipleStopWithTF:(UITextField *)textField;
-(void)passengsersButtonActionDelegateMultipleStopWithTF:(UITextField *)textField;
-(void)bookButtonActionDelegate;
-(void)addButtonActionDelegate;
-(void)removeButtonActionDelegate;

-(void)fromButtonActionDelegateFromMultipleViewAtIndex:(NSUInteger)index;
-(void)toButtonActionDelegateFromMultipleViewAtIndex:(NSUInteger)index;
-(void)dateButtonActionDelegateFromMultipleViewAtIndex:(NSUInteger)index withTextField:(UITextField *)textField;
-(void)flexibilityButtonActionDelegateFromMultipleViewAtIndex:(NSUInteger)index;
@end
