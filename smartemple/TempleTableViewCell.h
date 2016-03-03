//
//  TempleTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleModel.h"
@interface TempleTableViewCell : UITableViewCell

@property(nonatomic,strong) TempleModel *model;

@property(nonatomic,strong) UIImageView * templeimage;
@property(nonatomic,strong) UIImageView * masterimage;
@property(nonatomic,strong) UILabel * mastername;
@property(nonatomic,strong) UILabel * timelabel;
@property(nonatomic,strong) UILabel * templename;

@property(nonatomic,strong) UILabel * provincelabel;
@property(nonatomic,strong) UILabel * citylabel;


-(void) setup :(TempleModel *)model;

@end
