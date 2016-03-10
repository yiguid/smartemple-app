//
//  ActiviTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ActiviModel.h"
@interface ActiviTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel * templeLabel;
@property(nonatomic,strong) UILabel * viewLabel;
@property(nonatomic,strong) UIView * fengexianview;

-(void) setup :(ActiviModel *)model;

@end
