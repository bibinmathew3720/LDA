//
//  HomeViewController.m
//  LDA
//
//  Created by Bibin Mathew on 5/29/18.
//  Copyright © 2018 lda. All rights reserved.
//
#define FromKey @"fromKey"
#define ToKey @"toKey"
#define DepartKey @"depart"
#define FlexibilityKey @"flexibility"

#import "OneWayRoundView.h"
#import "MultipleStopView.h"

#import "HomeViewController.h"

typedef enum {
    OneWayRound = 0,
    MultipleStop = 1,
}ListType;

typedef enum{
    PickerTypeType = 0,
    PickerClassType = 1,
    PickerClassPassengers = 2,
    PickerTypeDepart = 3,
    PickerTypeFlexibility = 4
}PickerType;

@interface HomeViewController ()<OneWayRoundViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MultipleStopViewDelegate>
@property (nonatomic,strong) OneWayRoundView *onewayRoundView;
@property (nonatomic,strong) MultipleStopView *multipleStopView;
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) IBOutlet UIPickerView *tripTypePickerView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (nonatomic, strong) NSArray *tripTypeArray;
@property (nonatomic,assign) ListType listType;
@property(nonatomic, assign) PickerType selPickerType;
@property (nonatomic, strong) NSArray *classArray;
@property (nonatomic, strong) NSArray *passengersArray;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSMutableArray *tripArray;
@end

@implementation HomeViewController

-(void)initView{
    [super initView];
    [self initialisation];
    [self addingOneWayView];
    [self addingMultipleStopView];
    self.multipleStopView.hidden = YES;
    self.tripArray = [[NSMutableArray alloc] init];
    [self initialisingTripDictionary];
}

-(void)initialisation{
    self.title = @"Home";
    //Type Initialisation
    self.tripTypeArray = [NSArray arrayWithObjects:@"One Way",@"Return", nil];
    self.tripTypePickerView.dataSource = self;
    self.tripTypePickerView.delegate = self;
    //Class Initialisation
    self.classArray = @[@"Economy",@"Business",@"First Class",@"Premium Economy"];
    self.passengersArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
}

-(void)initialisingTripDictionary{
    NSMutableDictionary *tripDict = [[NSMutableDictionary alloc] init];
    [tripDict setValue:@"" forKey:FromKey];
     [tripDict setValue:@"" forKey:ToKey];
    [tripDict setValue:[self convertDate:[NSDate date] toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]] forKey:DepartKey];
    [tripDict setValue:@"Exact Day" forKey:FlexibilityKey];
    [self.tripArray addObject:tripDict];
    [self populateTripTableView];
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
    self.multipleStopView.multipleViewDelegate = self;
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
    if(self.selPickerType == PickerTypeType){
        self.onewayRoundView.tripTypeLabel.text = [self.tripTypeArray objectAtIndex:[self.tripTypePickerView selectedRowInComponent:0]];
    }
    else if(self.selPickerType == PickerClassType){
        if(self.listType == OneWayRound)
            self.onewayRoundView.classLabel.text = [self.classArray objectAtIndex:[self.tripTypePickerView selectedRowInComponent:0]];
        else
            self.multipleStopView.classLabel.text = [self.classArray objectAtIndex:[self.tripTypePickerView selectedRowInComponent:0]];
                
    }
    else if(self.selPickerType == PickerClassPassengers){
        if(self.listType == OneWayRound)
            self.onewayRoundView.passengersLabel.text =  [NSString stringWithFormat:@"Total %@",[self.passengersArray objectAtIndex:[self.tripTypePickerView selectedRowInComponent:0]]];
        else
            self.multipleStopView.passengersCountLabel.text = [NSString stringWithFormat:@"Total %@",[self.passengersArray objectAtIndex:[self.tripTypePickerView selectedRowInComponent:0]]];
    }
    else if (self.selPickerType == PickerTypeDepart){
        NSLog(@"Date Picker Date:%@",self.datePicker.date);
        self.onewayRoundView.departDateLabel.text = [self convertDate:self.datePicker.date toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]];
    }
    else if (self.selPickerType == PickerTypeFlexibility){
         self.onewayRoundView.flexibilityDateLabel.text = [self convertDate:self.datePicker.date toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]];
        
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
    self.selPickerType = PickerTypeType;
    [self.tripTypePickerView reloadAllComponents];
    tf.inputAccessoryView = self.toolBar;
    tf.inputView = self.tripTypePickerView;
    [tf becomeFirstResponder];
    NSInteger index = [self.tripTypeArray  indexOfObject:self.onewayRoundView.tripTypeLabel.text];
    [self.tripTypePickerView selectRow:index inComponent:0 animated:YES];
    
}

-(void)classButtonActionDelegateWithTF:(UITextField *)textField{
    self.selPickerType = PickerClassType;
    [self.tripTypePickerView reloadAllComponents];
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.tripTypePickerView;
    [textField becomeFirstResponder];
    NSInteger index = [self.classArray indexOfObject:self.onewayRoundView.classLabel.text];
    [self.tripTypePickerView selectRow:index inComponent:0 animated:YES];
}

-(void)departButtonActionDelegateWithTF:(UITextField *)textField{
    self.selPickerType = PickerTypeDepart;
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.datePicker;
    [textField becomeFirstResponder];
}

-(void)flexibiltyButtonActionDelegateWithTF:(UITextField *)textField{
    self.selPickerType = PickerTypeFlexibility;
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.datePicker;
    [textField becomeFirstResponder];
}

-(void)passengsersButtonActionDelegateWithTF:(UITextField *)textField{
    self.selPickerType = PickerClassPassengers;
    [self.tripTypePickerView reloadAllComponents];
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.tripTypePickerView;
    [textField becomeFirstResponder];
    NSInteger index = [self.passengersArray indexOfObject:[[self.onewayRoundView.passengersLabel.text  componentsSeparatedByString:@"Total "]lastObject]];
    [self.tripTypePickerView selectRow:index inComponent:0 animated:YES];
}

#pragma mark -UIPickerView Delegate and DataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    int rowCount = 0 ;
    switch (self.selPickerType) {
        case PickerTypeType:
            rowCount = (int)self.tripTypeArray.count;
            break;
        case PickerClassType:
            rowCount = (int)self.classArray.count;
            break;
        case PickerClassPassengers:
            rowCount = (int)self.passengersArray.count;
            break;
        default:
            break;
    }
    return rowCount;
}

- (nullable NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *title;
    switch (self.selPickerType) {
        case PickerTypeType:
           title = [_tripTypeArray objectAtIndex:row];
            break;
        case PickerClassType:
            title = [self.classArray objectAtIndex:row];
            break;
        case PickerClassPassengers:
            title = [self.passengersArray objectAtIndex:row];
            break;
        default:
            break;
    }
    return title;
}

- (IBAction)datePickerAction:(UIDatePicker *)sender {
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
}

#pragma mark - Multiple Stop View Delegates

-(void)classButtonActionDelegateFromMultipleStopWithTF:(UITextField *)textField{
    self.selPickerType = PickerClassType;
    [self.tripTypePickerView reloadAllComponents];
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.tripTypePickerView;
    [textField becomeFirstResponder];
    NSInteger index = [self.classArray indexOfObject:self.multipleStopView.classLabel.text];
    [self.tripTypePickerView selectRow:index inComponent:0 animated:YES];
}

-(void)passengsersButtonActionDelegateMultipleStopWithTF:(UITextField *)textField{
    self.selPickerType = PickerClassPassengers;
    [self.tripTypePickerView reloadAllComponents];
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.tripTypePickerView;
    [textField becomeFirstResponder];
    NSInteger index = [self.passengersArray indexOfObject:[[self.multipleStopView.passengersCountLabel.text  componentsSeparatedByString:@"Total "]lastObject]];
    [self.tripTypePickerView selectRow:index inComponent:0 animated:YES];
}

-(void)bookButtonActionDelegate{
    [self performSegueWithIdentifier:@"homeToPassengerDetails" sender:nil];
}

-(void)populateTripTableView{
    self.multipleStopView.tripArray = self.tripArray;
}

-(void)addButtonActionDelegate{
    [self.tripArray addObject:[self.tripArray lastObject]];
    [self populateTripTableView];
}

-(void)removeButtonActionDelegate{
    [self.tripArray removeLastObject];
    [self populateTripTableView];
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
