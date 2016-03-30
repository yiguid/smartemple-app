//
//  MasterCollectionViewCell.m
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MasterCollectionViewCell.h"
#import "smartemple.pch"
@implementation MasterCollectionViewCell

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
            
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0,0,wScreen/5,wScreen/5)];
        [self addSubview:self.imageView];
        self.title = [[UILabel alloc]initWithFrame:CGRectMake(0,wScreen/5,wScreen/5,20)];
        self.title.textAlignment = NSTextAlignmentCenter;
        self.title.font = TextFont;
        self.title.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
        [self addSubview:self.title];
        self.guanzhuimage = [[UIImageView alloc]initWithFrame:CGRectMake(15*wScreen/375,wScreen/5+20,10*wScreen/375,10*wScreen/375)];
        [self addSubview:self.guanzhuimage];
        self.guanzhulabel = [[UILabel alloc]initWithFrame:CGRectMake(30*wScreen/375,wScreen/5+15,wScreen/5,20*wScreen/375)];
        self.guanzhulabel.textAlignment = NSTextAlignmentLeft;
        self.guanzhulabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
        self.guanzhulabel.font = [UIFont systemFontOfSize:10];
        [self addSubview:self.guanzhulabel];
        
        

        
        
    }
    
    return self;
}


@end
