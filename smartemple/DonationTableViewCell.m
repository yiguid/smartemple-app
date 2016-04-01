//
//  DonationTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "DonationTableViewCell.h"
#import "smartemple.pch"
#import "UIImageView+WebCache.h"
@implementation DonationTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    self.templeimage = [[UIImageView alloc]init];
    [self.templeimage setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.templeimage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.templeimage.clipsToBounds  = YES;
    [self.contentView addSubview:self.templeimage];
    
    self.titleLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.titleLabel];
    
    self.viewLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.viewLabel];
    
    
   
    self.messageLabel = [[UILabel alloc]init];
    self.messageLabel.textColor=[UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1.0];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = TextFont;
    [self.contentView addSubview:self.messageLabel];
    
    self.fengexian = [[UIView alloc]init];
    self.fengexian.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [self.contentView addSubview:self.fengexian];
    
    
    return self;
    
}

- (void)layoutSubviews{
    
    
    self.templeimage.frame = CGRectMake(5, 5, wScreen/3-10, wScreen/3-10);
    self.titleLabel.frame = CGRectMake(wScreen/3+5, 5, wScreen, 20);
    
    CGSize textSize = [self sizeWithText:self.messageLabel.text font:TextFont maxSize:CGSizeMake(wScreen-wScreen/3-15, MAXFLOAT)];
    
    
    [self.messageLabel setFrame:CGRectMake(wScreen/3+5,30,wScreen-wScreen/3-15,textSize.height)];
    

    self.fengexian.frame = CGRectMake(5,wScreen/3, wScreen-10,0.5);
    self.viewLabel.frame = CGRectMake(wScreen/3+5,wScreen/3-25,wScreen/3,20);
    
    
}

- (void)setup:(DonationModel *)model{
    
    
    [self.templeimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.img]] placeholderImage:[UIImage imageNamed:@"shareImg.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.templeimage setImage:self.templeimage.image];
    }];
    self.titleLabel.text = model.title;
    self.messageLabel.text = model.Description;
    self.viewLabel.text = [NSString stringWithFormat:@"已有%@人关注",model.views];
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}




@end
