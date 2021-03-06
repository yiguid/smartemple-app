//
//  UserTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "UserTableViewCell.h"
#import "smartemple.pch"
@implementation UserTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.menuimage = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.menuimage];
    
    self.menuname = [[UILabel alloc]init];
    self.menuname.font = [UIFont systemFontOfSize:13];
//    self.menuname.textColor =[UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];

    [self.contentView addSubview:self.menuname];
    
    self.menuview = [[UIView alloc]init];
    self.menuview.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [self.contentView addSubview:self.menuview];
    
    self.menulabel = [[UILabel alloc]init];
    self.menulabel.textColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [self.contentView addSubview:self.menulabel];
    
    
    return self;
    
}

- (void)layoutSubviews{
    
    self.menuname.frame = CGRectMake(50,10,100,30);
    self.menuimage.frame = CGRectMake(10,15,20,20);
    self.menuview.frame = CGRectMake(10,49, wScreen-20,0.5);
    self.menulabel.frame = CGRectMake(wScreen-30, 10, 30, 30);
    
}


-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
