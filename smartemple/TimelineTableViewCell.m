//
//  TimelineTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "TimelineTableViewCell.h"
#import "smartemple.pch"
#import "UIImageView+WebCache.h"
@implementation TimelineTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    self.datetime = [[UILabel alloc]init];
    self.datetime.textColor=[UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.datetime.font = TextFont;
    [self.contentView addSubview:self.datetime];
    
    self.messageimage = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.messageimage];
    
    self.message = [[UILabel alloc]init];
    self.message.textColor=[UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1.0];
    self.message.numberOfLines = 0;
    self.message.font = TextFont;
    [self.contentView addSubview:self.message];
    
    
    
    return self;
    
}

- (void)layoutSubviews{
    
     CGSize textSize = [self sizeWithText:self.message.text font:TextFont maxSize:CGSizeMake(wScreen-80, MAXFLOAT)];
    [self.message setFrame:CGRectMake(60, 20, wScreen-80, textSize.height+20)];
    
    CGFloat heightmessage = CGRectGetMaxY(self.message.frame);
    
    
    self.datetime.frame = CGRectMake(10, 10,200, 15);
    self.messageimage.frame = CGRectMake(10, 30, 40, 40);
//    self.message.frame = CGRectMake(60, 20, wScreen-80,60);
    
    //头像圆形
    self.messageimage.layer.masksToBounds = YES;
    self.messageimage.layer.cornerRadius = self.messageimage.frame.size.width/2;

    self.cellHeight = heightmessage + 80;
    
}

- (void)setup:(Timelinemodel *)model{
    
    self.datetime.text = model.datetime;
    self.message.text = model.message;
    
    
    [self.messageimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.img]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.messageimage setImage:self.messageimage.image];
    }];

    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



@end
