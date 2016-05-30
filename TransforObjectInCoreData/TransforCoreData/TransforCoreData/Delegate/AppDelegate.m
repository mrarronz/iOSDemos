//
//  AppDelegate.m
//  TransforCoreData
//
//  Created by Arron Zhu on 16/1/13.
//  Copyright © 2016年 ArronZ. All rights reserved.
//

#import "AppDelegate.h"
#import "CoreDataWrapper.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {
    [[CoreDataWrapper instance] saveContext];
}

@end
