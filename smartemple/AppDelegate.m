//
//  AppDelegate.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "TempleViewController.h"
#import "MakeViewController.h"
#import "MyViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    MasterViewController * master=[[MasterViewController  alloc]init];
    TempleViewController * temple=[[TempleViewController alloc]init];
    MakeViewController * make=[[MakeViewController alloc]init];
    MyViewController * my=[[MyViewController alloc]init];
    self.window=[[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
    UITabBarController *tb=[[UITabBarController alloc]init];
    self.window.rootViewController=tb;
    master.tabBarItem.title=@"法师";
    master.tabBarItem.image=[UIImage imageNamed:@"dian.png"];
    temple.tabBarItem.title=@"寺院";
    temple.tabBarItem.image=[UIImage imageNamed:@"dian.png"];
    make.tabBarItem.title=@"发现";
    make.tabBarItem.image=[UIImage imageNamed:@"dian.png"];
    my.tabBarItem.title=@"个人";
    my.tabBarItem.image=[UIImage imageNamed:@"dian.png"];
    tb.viewControllers=@[master,temple,make,my];
      
    [self.window makeKeyAndVisible];
    
   
    
    return YES;

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
