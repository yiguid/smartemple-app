//
//  MasterCollectionViewCell.m
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MasterCollectionViewCell.h"

@implementation MasterCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //        self.backgroundColor = [UIColor grayColor];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10,0,60,60)];
        [self addSubview:self.imageView];
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(10,60,60, 20)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = [UIFont systemFontOfSize:12];
        self.title.textColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
        [self addSubview:self.title];
        self.guanzhuimage = [[UIImageView alloc]initWithFrame:CGRectMake(20,80,10,10)];
        [self addSubview:self.guanzhuimage];
        self.guanzhulabel = [[UILabel alloc]initWithFrame:CGRectMake(35,75,30, 20)];
        self.guanzhulabel.textAlignment = NSTextAlignmentLeft;
        self.guanzhulabel.textColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
        self.guanzhulabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.guanzhulabel];
        
        

        
        
    }
    
    return self;
}


@end