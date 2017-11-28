//
//  AppDelegate.h
//  ExpenceHelper
//
//  Created by Gaurav Bhadane on 19/11/17.
//  Copyright © 2017 GB. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end
