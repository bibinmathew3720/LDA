//
//  AppDelegate.h
//  LDA
//
//  Created by Bibin Mathew on 5/29/18.
//  Copyright © 2018 lda. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

