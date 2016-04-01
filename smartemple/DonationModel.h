//
//  DonationModel.h
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface DonationModel : NSObject

@property(nonatomic,copy)NSString * donationID;
@property(nonatomic,copy)NSString * Description;
@property(nonatomic,copy)NSString * views;
@property(nonatomic,copy)NSString * like;
@property(nonatomic,copy)NSString * endtime;
@property(nonatomic,copy)NSString * inputtime;
@property(nonatomic,copy)NSString * img;
@property(nonatomic,copy)NSString * title;
@property(nonatomic,copy)NSString * founderid;
@property(nonatomic,copy)NSString * target;
@property(nonatomic,copy)NSString * visible;
@property(nonatomic,copy)NSString * content;

@property(nonatomic,assign)CGFloat cellHigth;
-(CGFloat)getCellHeight;

@end
