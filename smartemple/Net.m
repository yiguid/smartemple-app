//
//  Net.m
//  IOS-登陆1009
//
//  Created by Apple_01 on 15/10/15.
//  Copyright (c) 2015年 Apple_01. All rights reserved.
//

#import "Net.h"

@implementation Net

+(BOOL)isHaveNetWork{
    //1.检测wifi状态
    
    Reachability * wifi = [Reachability reachabilityForLocalWiFi];
    
    //2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability * conn = [Reachability reachabilityForInternetConnection];
    
    //3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) {
        //有wifi
        NSLog(@"使用wifi");
        return YES;
        
    }
    else if([conn currentReachabilityStatus] != NotReachable){
        //没有使用wifi,使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        return YES;
        
    }else{
        //没有网络
        NSLog(@"没有网络");
        return NO;
    }
    
    
}



@end
