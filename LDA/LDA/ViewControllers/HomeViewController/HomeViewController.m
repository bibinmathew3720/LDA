//
//  HomeViewController.m
//  LDA
//
//  Created by Bibin Mathew on 5/29/18.
//  Copyright © 2018 lda. All rights reserved.
//

#define HomeToSearchIdentifier @"homeToSearch"

#import "SearchVC.h"
#import "OneWayRoundView.h"
#import "FlexibilityView.h"
#import "MultipleStopView.h"

#import "HomeViewController.h"
#import "PassengerDetailsVC.h"

#import "LanguageCell.h"

typedef enum {
    OneWayRound = 0,
    MultipleStop = 1,
}ListType;

typedef enum{
    PickerTypeType = 0,
    PickerClassType = 1,
    PickerClassPassengers = 2,
    PickerTypeDepart = 3,
    PickerTypeReturn = 4,
}PickerType;

typedef enum{
    TripTypeOneWay = 0,
    TripTypeReturn = 1,
}TripType;

@interface HomeViewController ()<OneWayRoundViewDelegate,UIPickerViewDataSource,UIPickerViewDelegate,MultipleStopViewDelegate,FlexibiltyViewDelegate,SearchVCDelegate,PassengerDetailsVCDelegate,UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) OneWayRoundView *onewayRoundView;
@property (nonatomic,strong) MultipleStopView *multipleStopView;
@property (weak,nonatomic) IBOutlet UISegmentedControl *segmentControl;

@property (strong, nonatomic) IBOutlet UIPickerView *tripTypePickerView;
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (nonatomic, strong) NSArray *tripTypeArray;
@property (nonatomic,assign) ListType listType;
@property(nonatomic, assign) PickerType selPickerType;
@property (nonatomic, assign) TripType tripType;
@property (nonatomic, strong) NSArray *classArray;
@property (nonatomic, strong) NSArray *passengersArray;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (nonatomic, strong) NSMutableArray *tripArray;
@property (nonatomic, assign) NSUInteger multipleViewSelectedIndex;

@property (nonatomic, strong) FlexibilityView *flexibiliyView;

@property (weak, nonatomic) IBOutlet UIView *languageGradientView;
@property (nonatomic, strong) NSArray *languagesArray;
@property (weak, nonatomic) IBOutlet UIView *languageView;

@property (nonatomic, strong) NSString *onewayClassSelectedString;
@property (nonatomic, strong) NSString *selTripTypeString;
@property (nonatomic, strong) NSArray *multipleWayClassSelectedString;
@property (nonatomic, strong) NSArray *englishClassArray;
@property (nonatomic, strong) NSArray *englishTripTypeArray;
@end

@implementation HomeViewController

-(void)initView{
    [super initView];
    [self initialisation];
    [self addingOneWayView];
    [self addingMultipleStopView];
    [self loadingFlexibilityView];
    self.multipleStopView.hidden = YES;
    self.tripArray = [[NSMutableArray alloc] init];
    [self hideReturnView];
    [self initialiseOneWayViewFields];
    [self initialiseMutiStopViewFields];
    [self.view bringSubviewToFront:self.languageGradientView];
    [self.view bringSubviewToFront:self.languageView];
}

-(void)initialisation{
    self.title = @"Home";
    //Type Initialisation
    self.tripTypeArray = [NSArray arrayWithObjects:NSLocalizedString(@"One Way", @"One Way"),NSLocalizedString(@"Return", @"Return"), nil];
    self.englishTripTypeArray = [NSArray arrayWithObjects:@"One Way",@"Return", nil];
    self.tripTypePickerView.dataSource = self;
    self.tripTypePickerView.delegate = self;
    //Class Initialisation
    self.classArray = @[NSLocalizedString(@"Economy", @"Economy"),NSLocalizedString(@"Business", @"Business"),NSLocalizedString(@"First Class", @"First Class"),NSLocalizedString(@"Premium Economy", @"Premium Economy")];
    self.englishClassArray = [NSArray arrayWithObjects:@"Economy",@"Business",@"First Class",@"Premium Economy", nil];
    self.passengersArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9"];
    self.multipleViewSelectedIndex = -1;
    self.navigationController.navigationBar.hidden = NO;
    self.navigationItem.hidesBackButton = YES;
    self.languagesArray = @[@"عربى",@"中文",@"English",@"français",@"Deutsche",@"русский",@"Español"];
   
}

-(void)initialisingTripDictionary{
    [self.tripArray removeAllObjects];
    NSMutableDictionary *tripDict = [[NSMutableDictionary alloc] init];
    [tripDict setValue:@"" forKey:FromCodeKey];
    [tripDict setValue:@"" forKey:FromPlaceKey];
    [tripDict setValue:@"" forKey:ToCodeKey];
    [tripDict setValue:@"" forKey:ToPlaceKey];
    [tripDict setValue:[self convertDate:[NSDate date] toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]] forKey:DepartKey];
    [tripDict setValue:@"Exact Day" forKey:FlexibilityKey];
    [self.tripArray addObject:tripDict];
    [self populateTripTableView];
}

-(void)loadingFlexibilityView{
    self.flexibiliyView = [[[NSBundle mainBundle] loadNibNamed:@"FlexibilityView" owner:self options:nil] objectAtIndex:0];
    self.flexibiliyView.frame = CGRectMake(0, 0, self.view.frame.size.width,self.view.frame.size.height);
    self.flexibiliyView.flexibilityDelegate = self;
    self.flexibiliyView.hidden = YES;
    [self.view addSubview:self.flexibiliyView];
}

#pragma mark - Flexibility View Delegate

-(void)selectedFlexibilityItem:(id)flexibilityItem{
    self.flexibiliyView.hidden = YES;
    if(self.listType == OneWayRound){
        if(self.selPickerType == PickerTypeDepart){
            self.onewayRoundView.flexibilityLabel.text = flexibilityItem;
        }
        else if (self.selPickerType == PickerTypeReturn){
            self.onewayRoundView.returnFlexibilityLabel.text = flexibilityItem;
        }
    }
    else if(self.listType == MultipleStop){
        NSMutableDictionary *selDictionary = [[self.tripArray objectAtIndex:self.multipleViewSelectedIndex] mutableCopy];
        [selDictionary setValue:flexibilityItem forKey:FlexibilityKey];
        [self.tripArray replaceObjectAtIndex:self.multipleViewSelectedIndex withObject:selDictionary];
        [self populateTripTableView];
    }
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
        if([self.tripTypePickerView selectedRowInComponent:0] == 0){
            self.tripType = TripTypeOneWay;
            [self hideReturnView];
        }
        else{
             self.tripType = TripTypeReturn;
            [self showReturnView];
        }
        NSInteger selRow = [self.tripTypePickerView selectedRowInComponent:0];
        self.onewayRoundView.tripTypeLabel.text = [self.tripTypeArray objectAtIndex:selRow];
        self.selTripTypeString = [self.englishTripTypeArray objectAtIndex:selRow];
    }
    else if(self.selPickerType == PickerClassType){
        if(self.listType == OneWayRound){
            NSInteger selRow = [self.tripTypePickerView selectedRowInComponent:0];
            self.onewayClassSelectedString = [self.englishClassArray objectAtIndex:selRow];
            self.onewayRoundView.classLabel.text = [self.classArray objectAtIndex:selRow];
        }
        else{
            NSInteger selRow = [self.tripTypePickerView selectedRowInComponent:0];
            self.multipleWayClassSelectedString = [self.englishClassArray objectAtIndex:selRow];
            self.multipleStopView.classLabel.text = [self.classArray objectAtIndex:selRow];
        }
                
    }
    else if(self.selPickerType == PickerClassPassengers){
        if(self.listType == OneWayRound)
            self.onewayRoundView.passengersLabel.text =  [NSString stringWithFormat:@"Total %@",[self.passengersArray objectAtIndex:[self.tripTypePickerView selectedRowInComponent:0]]];
        else
            self.multipleStopView.passengersCountLabel.text = [NSString stringWithFormat:@"Total %@",[self.passengersArray objectAtIndex:[self.tripTypePickerView selectedRowInComponent:0]]];
    }
    else if (self.selPickerType == PickerTypeDepart){
        NSLog(@"Date Picker Date:%@",self.datePicker.date);
        if(self.listType == OneWayRound){
                self.onewayRoundView.departDateLabel.text = [self convertDate:self.datePicker.date toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]];
        }
        else{
            NSString *dateString = [self convertDate:self.datePicker.date toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]];
            NSMutableDictionary *selDictionary = [[self.tripArray objectAtIndex:self.multipleViewSelectedIndex] mutableCopy];
            [selDictionary setValue:dateString forKey:DepartKey];
            [self.tripArray replaceObjectAtIndex:self.multipleViewSelectedIndex withObject:selDictionary];
            [self populateTripTableView];
        }
    }
    else if (self.selPickerType == PickerTypeReturn){
        self.onewayRoundView.returnDateLabel.text = [self convertDate:self.datePicker.date toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]];
    }
}

-(void)hideReturnView{
    self.onewayRoundView.returnView.hidden = YES;
    self.onewayRoundView.returnViewheightConstarint.constant = 0;
    self.onewayRoundView.returnTypeTopConstraint.constant = 0;
    self.onewayRoundView.returnFlexibilityView.hidden = YES;
}

-(void)showReturnView{
    self.onewayRoundView.returnView.hidden = NO;
    self.onewayRoundView.returnViewheightConstarint.constant = 70;
    self.onewayRoundView.returnTypeTopConstraint.constant = 20;
    self.onewayRoundView.returnFlexibilityView.hidden = NO;
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

-(void)fromButtonActionDelegate{
    [self performSegueWithIdentifier:HomeToSearchIdentifier sender:@"from"];
}

-(void)toButtonActionDelegate{
     [self performSegueWithIdentifier:HomeToSearchIdentifier sender:@"to"];
}

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
    self.datePicker.minimumDate = [NSDate date];
    self.selPickerType = PickerTypeDepart;
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.datePicker;
    [textField becomeFirstResponder];
}

-(void)flexibiltyButtonActionDelegateWithTF:(UITextField *)textField{
    self.selPickerType = PickerTypeDepart;
    self.flexibiliyView.hidden = NO;
}

-(void)returnButtonActionDelagateWithTF:(UITextField *)textField{
    self.datePicker.minimumDate = [self convertStringToDate:self.onewayRoundView.departDateLabel.text];
    self.selPickerType = PickerTypeReturn;
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.datePicker;
    [textField becomeFirstResponder];
}

-(void)returnFlexibilityButtonActionDelegateWithTF:(UITextField *)textField{
    self.selPickerType = PickerTypeReturn;
    self.flexibiliyView.hidden = NO;
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
    if(self.listType == OneWayRound)
        [self performSegueWithIdentifier:@"homeToPassengerDetails" sender:[self creatingJsonOfOneWayTrip]];
    else if(self.listType == MultipleStop){
        if([self isValidMultipleViewInput]){
            [self performSegueWithIdentifier:@"homeToPassengerDetails" sender:[self creatingJsonForMultipleStopView]];
        }
        else{
                [self showAlertWithTitle:NSLocalizedString(@"Warning", @"Warning") Message:NSLocalizedString(@"Please enter valid Source and Destination", @"Please enter valid Source and Destination") WithCompletion:^{
                    
                }];
        }
    }
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

//Multiple Stop View Cell Delegates

-(void)fromButtonActionDelegateFromMultipleViewAtIndex:(NSUInteger)index{
    self.multipleViewSelectedIndex = index;
    [self performSegueWithIdentifier:HomeToSearchIdentifier sender:@"from"];
}

-(void)toButtonActionDelegateFromMultipleViewAtIndex:(NSUInteger)index{
     self.multipleViewSelectedIndex = index;
    [self performSegueWithIdentifier:HomeToSearchIdentifier sender:@"to"];
}

-(void)dateButtonActionDelegateFromMultipleViewAtIndex:(NSUInteger)index withTextField:(UITextField *)textField{
    self.datePicker.minimumDate = [NSDate date];
    self.multipleViewSelectedIndex = index;
    self.selPickerType = PickerTypeDepart;
    textField.inputAccessoryView = self.toolBar;
    textField.inputView = self.datePicker;
    [textField becomeFirstResponder];
}

-(void)flexibilityButtonActionDelegateFromMultipleViewAtIndex:(NSUInteger)index{
     self.multipleViewSelectedIndex = index;
    self.flexibiliyView.hidden = NO;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"homeToSearch"]){
        SearchVC *searchVC = (SearchVC *)segue.destinationViewController;
        searchVC.searchDelegate = self;
        if([sender isEqualToString:@"from"]){
            searchVC.searchType = searchTypeFrom;
        }
        else{
            searchVC.searchType = searchTypeTo;
        }
    }
    else if ([segue.identifier isEqualToString:@"homeToPassengerDetails"]){
        PassengerDetailsVC *passengerDetails = (PassengerDetailsVC *)segue.destinationViewController;
        passengerDetails.passengerDetailsDelegate = self;
        if(self.listType == OneWayRound){
            passengerDetails.tripDetails = [self creatingJsonOfOneWayTrip];
            passengerDetails.tripType = TripTypeOneWayRound;
        }
        else{
                passengerDetails.tripDetails = [self creatingJsonForMultipleStopView];
                passengerDetails.tripType = TripTypeMultipleStop;
            }
        }
}

#pragma mark - Search VC Dlegates

-(void)selectedLocationWithDetails:(id)locationDetails withSearchType:(SearchType)searchType{
    if(self.listType == OneWayRound){
        if(searchType == searchTypeFrom){
            self.onewayRoundView.fromCodeLabel.text = [NSString stringWithFormat:@"%@",[locationDetails valueForKey:@"code"]];
            self.onewayRoundView.fromPlaceLabel.text = [NSString stringWithFormat:@"%@",[locationDetails valueForKey:@"airport"]];
        }
        else{
            self.onewayRoundView.toCodeLabel.text = [NSString stringWithFormat:@"%@",[locationDetails valueForKey:@"code"]];
            self.onewayRoundView.toPlaceLabel.text = [NSString stringWithFormat:@"%@",[locationDetails valueForKey:@"airport"]];
        }
    }
    else{
      
        NSMutableDictionary *selDictionary = [[self.tripArray objectAtIndex:self.multipleViewSelectedIndex] mutableCopy];
        if(searchType == searchTypeFrom){
            [selDictionary setValue:[locationDetails valueForKey:@"code"] forKey:FromCodeKey];
            [selDictionary setValue:[locationDetails valueForKey:@"airport"] forKey:FromPlaceKey];
        }
        else{
            [selDictionary setValue:[locationDetails valueForKey:@"code"] forKey:ToCodeKey];
            [selDictionary setValue:[locationDetails valueForKey:@"airport"] forKey:ToPlaceKey];
        }
        [self.tripArray replaceObjectAtIndex:self.multipleViewSelectedIndex withObject:selDictionary];
        [self populateTripTableView];
    }
}

-(id)creatingJsonOfOneWayTrip{
    NSMutableDictionary *mutDictionary = [[NSMutableDictionary alloc] init];
    [mutDictionary setValue:self.onewayClassSelectedString forKey:@"class"];
    [mutDictionary setValue:self.onewayRoundView.fromPlaceLabel.text forKey:@"outbound_from"];
    [mutDictionary setValue:self.onewayRoundView.fromCodeLabel.text forKey:@"fromCode"];
    [mutDictionary setValue:self.onewayRoundView.departDateLabel.text forKey:@"outbound_date"];
    [mutDictionary setValue:self.onewayRoundView.flexibilityLabel.text forKey:@"outbound_flexibility"];
    NSString *peopleSountString = [[self.onewayRoundView.passengersLabel.text componentsSeparatedByString:@"Total "] lastObject];
    [mutDictionary setValue:peopleSountString forKey:@"people"];
    if(self.tripType == TripTypeReturn){
       [mutDictionary setValue:[NSNumber numberWithBool:YES] forKey:@"returnFlag"];
    }
    else{
         [mutDictionary setValue:[NSNumber numberWithBool:NO] forKey:@"returnFlag"];
    }
     [mutDictionary setValue:self.onewayRoundView.toPlaceLabel.text forKey:@"outbound_to"];
    [mutDictionary setValue:self.onewayRoundView.toCodeLabel.text forKey:@"toCode"];
    [mutDictionary setValue:self.onewayRoundView.returnDateLabel.text forKey:@"return_date"];
    [mutDictionary setValue:self.onewayRoundView.returnFlexibilityLabel.text forKey:@"return_flexibility"];
    [mutDictionary setValue:@"One Way" forKey:@"type"];
    return mutDictionary;
}

-(id)creatingJsonForMultipleStopView{
    NSMutableDictionary *mutDictionary = [[NSMutableDictionary alloc] init];
    [mutDictionary setValue:self.multipleWayClassSelectedString forKey:@"class"];
    NSString *peopleCountString = [[self.multipleStopView.passengersCountLabel.text componentsSeparatedByString:@"Total "] lastObject];
    [mutDictionary setValue:peopleCountString forKey:@"people"];
    [mutDictionary setValue:[NSNumber numberWithBool:NO] forKey:@"returnFlag"];
    [mutDictionary setValue:@"Multi Stop" forKey:@"type"];
    [mutDictionary setValue:self.tripArray forKey:@"info"];
    return mutDictionary;
}

-(BOOL)isValidMultipleViewInput{
    for (id trip in self.tripArray){
        if(([[trip valueForKey:FromCodeKey] length] == 0) || ([[trip valueForKey:ToCodeKey] length] == 0)){
            return NO;
        }
    }
    return YES;
}

#pragma mark - Passenger Details Delegate

-(void)tripDetailsSubmittedDelegate{
    if(self.tripType == TripTypeOneWay){
        [self initialiseOneWayViewFields];
    }
    else{
        [self initialiseMutiStopViewFields];
    }
}

-(void)initialiseOneWayViewFields{
    self.onewayRoundView.fromCodeLabel.text = @"LCF";
    self.onewayRoundView.fromPlaceLabel.text = @"Las VEgas Airport";
    self.onewayRoundView.toCodeLabel.text = @"WWK";
    self.onewayRoundView.toPlaceLabel.text = @"Wewak International";
    self.onewayRoundView.tripTypeLabel.text = [self.tripTypeArray firstObject];
    self.selTripTypeString = [self.englishTripTypeArray firstObject];
     self.onewayRoundView.classLabel.text = [self.classArray firstObject];
    self.onewayClassSelectedString = [self.englishClassArray firstObject];
    self.onewayRoundView.departDateLabel.text = [self convertDate:[NSDate date] toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    NSDate *today = [NSDate date];
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    NSDate *currentDate = [calendar dateByAddingComponents:comps toDate:today options:0];
     self.onewayRoundView.returnDateLabel.text = [self convertDate:currentDate toFormatedString:@"yyyy-MM-dd" withTimeZone:[NSTimeZone systemTimeZone]];
    
    self.onewayRoundView.flexibilityLabel.text = @"Exact Date";
    self.onewayRoundView.passengersLabel.text = @"Total 1";
    self.tripType = TripTypeOneWay;
    [self hideReturnView];
    
    
}

-(void)initialiseMutiStopViewFields{
    [self initialisingTripDictionary];
    self.multipleStopView.classLabel.text = [self.classArray firstObject];
    self.multipleWayClassSelectedString = [self.englishClassArray firstObject];
    self.multipleStopView.passengersCountLabel.text = @"Total 1";
}

//For Localization List View

- (IBAction)languageButtonAction:(UIBarButtonItem *)sender {
    self.languageGradientView.hidden = !self.languageGradientView.isHidden;
    self.languageView.hidden = !self.languageView.isHidden;
}

#pragma mark - UITable View Datasources

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.languagesArray.count;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    LanguageCell *languageCell = [tableView dequeueReusableCellWithIdentifier:@"languageCell"];
    languageCell.languageLabel.text = [self.languagesArray objectAtIndex:indexPath.row];
    return languageCell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *languseString = @"en";
    switch (indexPath.row) {
        case 0:
            languseString = @"ar";//Arabic
            break;
        case 1:
           languseString = @"zh-Hans"; //Chinese
            break;
        case 2:
             languseString = @"en"; //English
            break;
        case 3:
           languseString = @"fr"; //French
            break;
        case 4:
            languseString = @"de"; //German
            break;
        case 5:
           languseString = @"ru"; //Russian
            break;
        case 6:
            languseString = @"es"; //Spanish
            break;
        default:
            break;
    }
    [[NSUserDefaults standardUserDefaults] setObject:[NSArray arrayWithObjects:languseString, nil] forKey:@"AppleLanguages"];
    [self showAlertWithTitle:APPNAME Message:NSLocalizedString(@"Language changes will take effect after restarting the application", @"Language changes will take effect after restarting the application") WithCompletion:^{
        exit(0);
    }];
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
