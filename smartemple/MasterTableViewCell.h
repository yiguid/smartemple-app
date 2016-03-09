//
//  MasterTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/9.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "masterModel.h"
@interface MasterTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *title;
@property(nonatomic, strong)UIImageView *userimage;
@property(nonatomic, strong)UILabel *templename;
@property(nonatomic, strong)UILabel * renqilabel;
@property(nonatomic, strong)UILabel * guanzhulabel;
@property(nonatomic,strong)UIView * fengexian;


-(void) setup :(masterModel *)model;

@end
