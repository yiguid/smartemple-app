//
//  TimelineTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Timelinemodel.h"
@interface TimelineTableViewCell : UITableViewCell

@property(nonatomic,strong)Timelinemodel *model;

@property(nonatomic,strong)UILabel * datetime;
@property(nonatomic,strong)UIImageView * messageimage;
@property(nonatomic,strong)UILabel * message;
@property(nonatomic,strong)UIView * fengexian;

-(void) setup :(Timelinemodel *)model;

@end
