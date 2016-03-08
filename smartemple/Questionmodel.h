//
//  Questionmodel.h
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface Questionmodel : NSObject

@property(nonatomic,copy)NSString * location;
@property(nonatomic,copy)NSString * answer;
@property(nonatomic,copy)NSString * question;
@property(nonatomic,copy)NSString * master;
@property(nonatomic,copy)NSString * user;

@property(nonatomic,assign)CGFloat cellHigth;
-(CGFloat)getCellHeight;

@end
