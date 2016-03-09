//
//  TempleModel.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface TempleModel : NSObject

@property(nonatomic,copy)NSString * name;
@property(nonatomic,copy)NSString * province;
@property(nonatomic,copy)NSString * city;
@property(nonatomic,copy)NSString * master;
@property(nonatomic,copy)NSString * homeimg;
@property(nonatomic,copy)NSString * avatar;
@property(nonatomic,copy)NSString * views;
@property(nonatomic,copy)NSString * website;
@property(nonatomic,copy)NSString * templeid;
@property(nonatomic,copy)NSString * masterid;

@property(nonatomic,assign)CGFloat cellHigth;
-(CGFloat)getCellHeight;

@end
