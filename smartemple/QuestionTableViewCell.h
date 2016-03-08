//
//  QuestionTableViewCell.h
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Questionmodel.h"
@interface QuestionTableViewCell : UITableViewCell

@property(nonatomic,strong) UILabel * questionlabel;
@property(nonatomic,strong) UILabel * question;
@property(nonatomic,strong) UILabel * answerlabel;
@property(nonatomic,strong) UILabel * answer;
@property(nonatomic,strong)UIView * fengexian;

-(void) setup :(Questionmodel *)model;

@end
