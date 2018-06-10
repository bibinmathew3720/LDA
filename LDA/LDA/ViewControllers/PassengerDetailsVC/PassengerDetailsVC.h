//
//  PassengerDetailsVC.h
//  LDA
//
//  Created by Bibin Mathew on 6/6/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import "BaseViewController.h"
typedef enum{
  TripTypeOneWayRound = 0,
  TripTypeMultipleStop = 1,
}PaasengerTripType;
@interface PassengerDetailsVC : BaseViewController
@property (nonatomic, strong) id tripDetails;
@property (nonatomic, assign) PaasengerTripType tripType;
@end
