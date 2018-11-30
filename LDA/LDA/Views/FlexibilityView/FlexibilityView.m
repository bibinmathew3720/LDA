//
//  FlexibilityView.m
//  LDA
//
//  Created by "" on 6/8/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "FlexiblityCVC.h"
#import "FlexibilityView.h"

@interface FlexibilityView()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *flexibilityCollectionView;
@property (nonatomic, strong) NSArray *flexibilityArray;
@end
@implementation FlexibilityView
-(void)awakeFromNib{
    [super awakeFromNib];
    [self initialisation];
    [self initialisingDataArray];
}

-(void)initialisation{
    self.flexibilityCollectionView.dataSource = self;
    self.flexibilityCollectionView.delegate = self;
     [self.flexibilityCollectionView registerNib: [UINib nibWithNibName:@"FlexiblityCVC" bundle:nil] forCellWithReuseIdentifier:@"flexibilityCell"];
}

-(void)initialisingDataArray{
    self.flexibilityArray = @[@"(+) 1 day",@"(-) 1 day",@"(+/-) 1 day",@"(+) 2 days",@"(-) 2 days",@"(+/-) 2 days",@"(+) 3 days",@"(-) 3 days",@"(+/-) 3 days",@"(+) 4 days",@"(-) 4 days",@"(+/-) 4 days",@"(+) 5 days",@"(-) 5 days",@"(+/-) 5 days",@"(+) 1 week",@"(-) 1 week",@"(+/-) 1 week",@"(+) 2 weeks",@"(-) 2 weeks",@"(+/-) 2 weeks",@"(+) 3 weeks",@"(-) 3 weeks",@"(+/-) 3 weeks",@"(+) 1 month",@"(-) 1 month",@"(+/-) 1 month",@"(+) 2 months",@"(-) 2 months",@"(+/-) 2 months",@"(+) 3 months",@"(-) 3 months",@"(+/-) 3 months",@"(+) 6 months",@"(-) 6 months",@"(+/-) 6 months",@"Exact Date"];
}

#pragma mark - UICollection View Datasources

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
        return self.flexibilityArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    FlexiblityCVC *flexiblityCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"flexibilityCell" forIndexPath:indexPath];
    flexiblityCell.flexibilityLabel.text = [self.flexibilityArray objectAtIndex:indexPath.row];
    return flexiblityCell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Cell Size:%f",self.frame.size.width);
    return CGSizeMake(100, 40);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}

#pragma mark - UICollection View Delegates

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(self.flexibilityDelegate && [self.flexibilityDelegate respondsToSelector:@selector(selectedFlexibilityItem:)]){
        [self.flexibilityDelegate selectedFlexibilityItem:[self.flexibilityArray objectAtIndex:indexPath.row]];
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
