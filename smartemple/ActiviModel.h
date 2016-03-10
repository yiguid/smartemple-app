//
//  ActiviModel.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface ActiviModel : NSObject

@property(nonatomic,copy)NSString * location;
@property(nonatomic,copy)NSString * views;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * Description;
@property(nonatomic,copy)NSString * starttime;
@property(nonatomic,copy)NSString * endtime;
@property(nonatomic,copy)NSString * type;
-(CGFloat)getCellHeight;

@end
