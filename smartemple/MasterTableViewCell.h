//
//  MasterTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/4.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "masterModel.h"
@interface MasterTableViewCell : UITableViewCell

@property(nonatomic, strong)UILabel *title;
@property(nonatomic, strong)UIImageView * masterimage;
@property(nonatomic, strong)UILabel *templename;
@property(nonatomic, strong)UIImageView * guanzhuimage;
@property(nonatomic, strong)UILabel * guanzhulabel;

-(void) setup :(masterModel *)model;

@end
