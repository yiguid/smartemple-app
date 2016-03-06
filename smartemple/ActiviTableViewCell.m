//
//  ActiviTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "ActiviTableViewCell.h"
#import "smartemple.pch"
@implementation ActiviTableViewCell

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
    
    self.desLabel = [[UILabel alloc]init];
    self.desLabel.font = TextFont;
    self.desLabel.numberOfLines = 0;
    [self.contentView addSubview:self.desLabel];
    
    self.viewLabel = [[UILabel alloc]init];
    self.viewLabel.textColor = [UIColor colorWithRed:220/255.0 green:220/255.0 blue:220/255.0 alpha:1.0];
    self.viewLabel.font = TextFont;
    self.viewLabel.numberOfLines = 0;
    [self.contentView addSubview:self.viewLabel];
    
    
    
    return self;
    
}

- (void)layoutSubviews{
    
    self.templeLabel.frame = CGRectMake(10, 10,100,50);
    self.desLabel.frame = CGRectMake(110, 10, wScreen-200,50);
    self.viewLabel.frame = CGRectMake(wScreen-80,20, 60, 30);
    
    
    
}

- (void)setup:(ActiviModel *)model{
    
    self.templeLabel.text = [NSString stringWithFormat:@"[%@]",model.title];
    self.desLabel.text = model.Description;
    self.viewLabel.text = [NSString stringWithFormat:@"阅读:%@",model.views];
    
    
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
