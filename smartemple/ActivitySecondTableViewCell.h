//
//  ActivitySecondTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiviModel.h"
@interface ActivitySecondTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel * templetitle;
@property(nonatomic,strong) UILabel * timelabel;
@property(nonatomic,strong) UILabel * moneylabel;
@property(nonatomic,strong) UILabel * messagelabel;



-(void) setup :(ActiviModel *)model;

@end
