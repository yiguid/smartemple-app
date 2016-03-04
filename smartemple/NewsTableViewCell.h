//
//  NewsTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewsModel.h"
@interface NewsTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel * templeLabel;
@property(nonatomic,strong) UILabel * desLabel;
@property(nonatomic,strong) UILabel * viewLabel;

-(void) setup :(NewsModel *)model;

@end
