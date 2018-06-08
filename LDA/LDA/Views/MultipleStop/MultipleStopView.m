//
//  MultipleStopView.m
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "MultipleStopView.h"
#import "MultipleStopTVC.h"

@implementation MultipleStopView

-(void)awakeFromNib{
    [super awakeFromNib];
    self.multipleStopTableView.dataSource = self;
    self.multipleStopTableView.delegate = self;
     [self.multipleStopTableView registerNib:[UINib nibWithNibName:@"MultipleStopTVC" bundle:nil] forCellReuseIdentifier:@"multipleStopTVC"];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    MultipleStopTVC *multipleStopCell = [tableView dequeueReusableCellWithIdentifier:@"multipleStopTVC" forIndexPath:indexPath];
    return multipleStopCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

#pragma mark - Button Actions

- (IBAction)addButtonAction:(UIButton *)sender {
}
- (IBAction)removeButtonAction:(UIButton *)sender {
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
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
