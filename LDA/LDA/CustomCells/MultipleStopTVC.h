//
//  MultipleStopTVC.h
//  LDA
//
//  Created by "" on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MultipleStopTVCDelegate;
@interface MultipleStopTVC : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *fromCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fromLabel;
@property (weak, nonatomic) IBOutlet UIButton *fromButton;
@property (weak, nonatomic) IBOutlet UILabel *toCodeLabel;
@property (weak, nonatomic) IBOutlet UILabel *toLabel;
@property (weak, nonatomic) IBOutlet UIButton *toButton;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateLabel;
@property (weak, nonatomic) IBOutlet UITextField *flexibilityLabel;
@property (nonatomic, assign) id <MultipleStopTVCDelegate>multipleStopCellDelegate;
@property (nonatomic, strong) id dataDictionary;
@end
@protocol MultipleStopTVCDelegate<NSObject>
-(void)fromButtonActionDelegateWithIndex:(NSInteger)index;
-(void)toButtonActionDelegateWithIndex:(NSInteger)index;
-(void)dateButtonActionDelegateWithIndex:(NSUInteger)index withtextField:(UITextField *)textField;;
-(void)flexibilityButtonActionDelegateWithIndex:(NSUInteger)index;
@end
