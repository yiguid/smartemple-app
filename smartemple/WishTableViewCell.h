//
//  WishTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Wishmodel.h"
@interface WishTableViewCell : UITableViewCell

@property(nonatomic,strong)UILabel * username;
@property(nonatomic,strong)UILabel * datetime;
@property(nonatomic,strong)UILabel * messagelabel;
@property(nonatomic,strong)UILabel * message;
@property(nonatomic,strong)UILabel * donationcontent;
@property(nonatomic,strong)UIView * fengexian;

-(void) setup :(Wishmodel *)model;

@end
