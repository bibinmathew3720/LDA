//
//  MultipleStopTVC.m
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "Constants.h"
#import "MultipleStopTVC.h"

@implementation MultipleStopTVC

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setDataDictionary:(id)dataDictionary{
    self.dateLabel.text = [dataDictionary valueForKey:DepartKey];
    self.flexibilityLabel.text = [dataDictionary valueForKey:FlexibilityKey];
    NSString *fromCodeString = [dataDictionary valueForKey:FromCodeKey];
    if(fromCodeString.length != 0){
        [self.fromButton setTitle:@"" forState:UIControlStateNormal];
        self.fromCodeLabel.text = [dataDictionary valueForKey:FromCodeKey];
        self.fromLabel.text = [dataDictionary valueForKey:FromPlaceKey];
    }
    else{
        [self.fromButton setTitle:@"FROM" forState:UIControlStateNormal];
        self.fromCodeLabel.text = @"";
        self.fromLabel.text = @"";
    }
    NSString *toCodeString = [dataDictionary valueForKey:ToCodeKey];
    if(toCodeString.length != 0){
        [self.toButton setTitle:@"" forState:UIControlStateNormal];
        self.toCodeLabel.text = [dataDictionary valueForKey:ToCodeKey];
        self.toLabel.text = [dataDictionary valueForKey:ToPlaceKey];
    }
    else{
        [self.toButton setTitle:@"TO" forState:UIControlStateNormal];
        self.toCodeLabel.text = @"";
        self.toLabel.text = @"";
    }
}

- (IBAction)fromButtonAction:(UIButton *)sender {
    if(self.multipleStopCellDelegate && [self.multipleStopCellDelegate respondsToSelector:@selector(fromButtonActionDelegateWithIndex:)]){
        [self.multipleStopCellDelegate fromButtonActionDelegateWithIndex:self.tag];
    }
}
- (IBAction)toButtonAction:(UIButton *)sender {
    if(self.multipleStopCellDelegate && [self.multipleStopCellDelegate respondsToSelector:@selector(toButtonActionDelegateWithIndex:)]){
        [self.multipleStopCellDelegate toButtonActionDelegateWithIndex:self.tag];
    }
}
- (IBAction)dateButtonAction:(UIButton *)sender {
    if(self.multipleStopCellDelegate && [self.multipleStopCellDelegate respondsToSelector:@selector(dateButtonActionDelegateWithIndex:withtextField:)]){
        [self.multipleStopCellDelegate dateButtonActionDelegateWithIndex:self.tag withtextField:self.dateTextField];
    }
}
- (IBAction)flexibilityButtonAction:(UIButton *)sender {
    if(self.multipleStopCellDelegate && [self.multipleStopCellDelegate respondsToSelector:@selector(flexibilityButtonActionDelegateWithIndex:)]){
        [self.multipleStopCellDelegate flexibilityButtonActionDelegateWithIndex:self.tag];
    }
}

@end
