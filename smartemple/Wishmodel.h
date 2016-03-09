//
//  Wishmodel.h
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Wishmodel : NSObject

@property(nonatomic,copy)NSString * userid;
@property(nonatomic,copy)NSString * content;
@property(nonatomic,copy)NSString * datetime;
@property(nonatomic,copy)NSString * location;
@property(nonatomic,copy)NSString * donationcontent;
@property(nonatomic,assign)CGFloat cellHigth;
-(CGFloat)getCellHeight;

@end
