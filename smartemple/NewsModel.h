//
//  NewsModel.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NewsModel : NSObject

@property(nonatomic,copy)NSString * updatetime;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * Description;
@property(nonatomic,copy)NSString * views;
@property(nonatomic,copy)NSString * realname;
@property(nonatomic,copy)NSString * like;

-(CGFloat)getCellHeight;


@end
