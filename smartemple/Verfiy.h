//
//  Verfiy.h
//  IOS-登陆1009
//
//  Created by Apple_01 on 15/10/10.
//  Copyright (c) 2015年 Apple_01. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Verfiy : NSObject

-(BOOL)validateMobile:(NSString *)mobileNum;

-(BOOL)isValidateEmail:(NSString *)email;

- (BOOL)isPureInt:(NSString*)string;

@end
