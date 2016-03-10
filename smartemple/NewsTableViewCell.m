//
//  NewsTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "smartemple.pch"
@implementation NewsTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    self.templeLabel = [[UILabel alloc]init];
    self.templeLabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.templeLabel.font = TextFont;
    self.templeLabel.numberOfLines = 0;
    [self.contentView addSubview:self.templeLabel];
    
    self.viewLabel = [[UILabel alloc]init];
    self.viewLabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.viewLabel.font = TextFont;
    self.viewLabel.numberOfLines = 0;
    [self.contentView addSubview:self.viewLabel];
    
    self.fengexianview = [[UIView alloc]init];
    self.fengexianview.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [self.contentView addSubview:self.fengexianview];
    
    return self;
    
}

- (void)layoutSubviews{
    
    CGSize textSize = [self sizeWithText:self.templeLabel.text font:TextFont maxSize:CGSizeMake(wScreen-100, MAXFLOAT)];
    
    [self.templeLabel setFrame:CGRectMake(10,10, wScreen-100,textSize.height)];

    self.viewLabel.frame = CGRectMake(wScreen-80,8,60,20);
    
    self.fengexianview.frame = CGRectMake(10, textSize.height+20, wScreen-20, 0.5);
    
}

- (void)setup:(NewsModel *)model{
    
    self.templeLabel.text = [NSString stringWithFormat:@"%@",model.title];
    self.viewLabel.text = [NSString stringWithFormat:@"阅读: %@",model.views];
    
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
