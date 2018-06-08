//
//  MultipleStopView.m
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#define CellHeight 100

#import "MultipleStopView.h"
#import "MultipleStopTVC.h"
@interface MultipleStopView()<MultipleStopTVCDelegate>
@property (nonatomic, strong) NSArray *currentTripArray;
@end
@implementation MultipleStopView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.multipleStopTableView.dataSource = self;
    self.multipleStopTableView.delegate = self;
     [self.multipleStopTableView registerNib:[UINib nibWithNibName:@"MultipleStopTVC" bundle:nil] forCellReuseIdentifier:@"multipleStopTVC"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.currentTripArray.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MultipleStopTVC *multipleStopCell = [tableView dequeueReusableCellWithIdentifier:@"multipleStopTVC" forIndexPath:indexPath];
    multipleStopCell.multipleStopCellDelegate = self;
    multipleStopCell.dataDictionary = [self.currentTripArray objectAtIndex:indexPath.section];
    multipleStopCell.tag = indexPath.section;
    return multipleStopCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return CellHeight;
}

#pragma mark - Button Actions

- (IBAction)addButtonAction:(UIButton *)sender {
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(addButtonActionDelegate)]){
        [self.multipleViewDelegate addButtonActionDelegate];
    }
}
- (IBAction)removeButtonAction:(UIButton *)sender {
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(removeButtonActionDelegate)]){
        [self.multipleViewDelegate removeButtonActionDelegate];
    }
}
- (IBAction)classButtonAction:(UIButton *)sender {
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(classButtonActionDelegateFromMultipleStopWithTF:)]){
        [self.multipleViewDelegate classButtonActionDelegateFromMultipleStopWithTF:self.classTF];
    }
}
- (IBAction)passengersButtonAction:(UIButton *)sender {
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(passengsersButtonActionDelegateMultipleStopWithTF:)]){
        [self.multipleViewDelegate passengsersButtonActionDelegateMultipleStopWithTF:self.passengersTF];
    }
}
- (IBAction)bookButtonAction:(UIButton *)sender {
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(bookButtonActionDelegate)]){
        [self.multipleViewDelegate bookButtonActionDelegate];
    }
}

-(void)setTripArray:(NSArray *)tripArray{
    self.currentTripArray = tripArray;
    self.tableViewHeightConstraint.constant = tripArray.count*CellHeight;
    if(tripArray.count == 1){
        [self.removeButton setBackgroundColor:[[UIColor lightGrayColor] colorWithAlphaComponent:0.4]];
        self.removeButton.userInteractionEnabled = NO;
    }
    else{
        [self.removeButton setBackgroundColor:[UIColor whiteColor]];
        self.removeButton.userInteractionEnabled = YES;
    }
    [self.multipleStopTableView reloadData];
}

#pragma mark - Table Cell Delegates

-(void)fromButtonActionDelegateWithIndex:(NSInteger)index{
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(fromButtonActionDelegateFromMultipleViewAtIndex:)]){
        [self.multipleViewDelegate fromButtonActionDelegateFromMultipleViewAtIndex:index];
    }
}

-(void)toButtonActionDelegateWithIndex:(NSInteger)index{
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(toButtonActionDelegateFromMultipleViewAtIndex:)]){
        [self.multipleViewDelegate toButtonActionDelegateFromMultipleViewAtIndex:index];
    }
}

-(void)dateButtonActionDelegateWithIndex:(NSUInteger)index withtextField:(UITextField *)textField{
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(dateButtonActionDelegateFromMultipleViewAtIndex:withTextField:)]){
        [self.multipleViewDelegate dateButtonActionDelegateFromMultipleViewAtIndex:index withTextField:textField];
    }
}

-(void)flexibilityButtonActionDelegateWithIndex:(NSUInteger)index{
    if(self.multipleViewDelegate && [self.multipleViewDelegate respondsToSelector:@selector(flexibilityButtonActionDelegateFromMultipleViewAtIndex:)]){
        [self.multipleViewDelegate flexibilityButtonActionDelegateFromMultipleViewAtIndex:index];
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
