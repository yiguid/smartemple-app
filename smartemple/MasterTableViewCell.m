//
//  MasterTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/4.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MasterTableViewCell.h"
#import "smartemple.pch"
#import "UIImageView+WebCache.h"
@implementation MasterTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    self.masterimage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.masterimage];
    
    self.title = [[UILabel alloc]init];
    self.title.textAlignment = NSTextAlignmentCenter;
    self.title.font = TextFont;
    self.title.textColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
    [self addSubview:self.title];
    
    
    self.guanzhuimage = [[UIImageView alloc]init];
    [self addSubview:self.guanzhuimage];
    self.guanzhulabel = [[UILabel alloc]init];
    self.guanzhulabel.textAlignment = NSTextAlignmentLeft;
    self.guanzhulabel.textColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
    self.guanzhulabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.guanzhulabel];
    
    
    
    
    return self;
    
}

- (void)layoutSubviews{
    
    self.masterimage.frame = CGRectMake(10, 10, 60, 60);
    
    
    
}

- (void)setup:(masterModel *)model{
    
       
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
