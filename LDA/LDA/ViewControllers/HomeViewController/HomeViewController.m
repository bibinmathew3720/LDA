//
//  HomeViewController.m
//  LDA
//
//  Created by Bibin Mathew on 5/29/18.
//  Copyright © 2018 lda. All rights reserved.
//
#import "OneWayRoundView.h"
#import "MultipleStopView.h"

#import "HomeViewController.h"

typedef enum {
    OneWayRound = 0,
    MultipleStop = 1,
}ListType;

@interface HomeViewController ()<OneWayRoundViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate>
@property (nonatomic,strong) OneWayRoundView *onewayRoundView;
@property (nonatomic,strong) MultipleStopView *multipleStopView;
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) IBOutlet UIPickerView *tripTypePickerView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (nonatomic, strong) NSArray *tripTypeArray;
@property (nonatomic,assign) ListType listType;
@property(nonatomic, assign) NSInteger selPickerTag;
@end

@implementation HomeViewController

-(void)initView{
    [super initView];
    [self initialisation];
    [self addingOneWayView];
    [self addingMultipleStopView];
    self.multipleStopView.hidden = YES;
    
}
-(void)initialisation{
    self.title = @"Home";
    self.tripTypeArray = [NSArray arrayWithObjects:@"One Way",@"Return", nil];
    self.tripTypePickerView.dataSource = self;
    self.tripTypePickerView.delegate = self;
}

-(void)addingOneWayView{
    self.onewayRoundView = [[[NSBundle mainBundle] loadNibNamed:@"OneWayRoundView" owner:self options:nil] objectAtIndex:0];
    self.onewayRoundView.frame = CGRectMake(0, self.segmentControl.bottom+10, self.view.frame.size.width, self.view.frame.size.height-self.segmentControl.bottom-10);
    self.onewayRoundView.onewayViewDelegate = self;
    [self.view addSubview:self.onewayRoundView];
}
-(void)addingMultipleStopView{
    self.multipleStopView = [[[NSBundle mainBundle] loadNibNamed:@"MultipleStopView" owner:self options:nil] objectAtIndex:0];
    self.multipleStopView.frame = CGRectMake(0, self.segmentControl.bottom+10, self.view.frame.size.width, self.view.frame.size.height-self.segmentControl.bottom-10);
    [self.view addSubview:self.multipleStopView];
}

- (IBAction)segmentControlAction:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0)
        self.listType = OneWayRound;
    else
        self.listType = MultipleStop;
    [self showingListing];
}

- (IBAction)toolBarDoneButtonAction:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
    if(self.selPickerTag == 1000){
        self.onewayRoundView.tripTypeLabel.text = [self.tripTypeArray objectAtIndex:[self.tripTypePickerView selectedRowInComponent:0]];
    }
}

- (IBAction)toolBArCanceButtonAction:(UIBarButtonItem *)sender {
    [self.view endEditing:YES];
}

-(void)showingListing{
    if(self.listType == OneWayRound){
        self.onewayRoundView.hidden = NO;
        self.multipleStopView.hidden = YES;
    }
    else{
        self.onewayRoundView.hidden = YES;
        self.multipleStopView.hidden = NO;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Oneway Round view Delegate

-(void)tripTypeButtonActionDelegateWithTF:(UITextField *)tf{
    tf.inputAccessoryView = self.toolBar;
    tf.inputView = self.tripTypePickerView;
    self.selPickerTag = self.tripTypePickerView.tag;
    [tf becomeFirstResponder];
    
}

#pragma mark -UIPickerView Delegate and DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    int rowCount = 0 ;
    switch (pickerView.tag) {
        case 1000:
            rowCount = (int)self.tripTypeArray.count;
            break;
        default:
            break;
    }
    return rowCount;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    switch (pickerView.tag) {
        case 1000:
           title = [_tripTypeArray objectAtIndex:row];
            break;
        default:
            break;
    }
    return title;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
