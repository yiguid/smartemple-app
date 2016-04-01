//
//  DonationTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DonationModel.h"
@interface DonationTableViewCell : UITableViewCell

@property(nonatomic,strong)UIImageView * templeimage;
@property(nonatomic,strong)UILabel * titleLabel;
@property(nonatomic,strong)UILabel * messageLabel;
@property(nonatomic,strong)UILabel * viewLabel;
@property(nonatomic,strong)UIView * fengexian;

-(void) setup :(DonationModel *)model;

@end
