//
//  MultipleStopView.h
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MultipleStopView : UIView<UITableViewDataSource,UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UITableView *multipleStopTableView;

@end
