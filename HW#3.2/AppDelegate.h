//
//  AppDelegate.h
//  HW#3.2
//
//  Created by Evgheny on 29.09.16.
//  Copyright © 2016 Eugheny_Levin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (void)saveContext;


@end

