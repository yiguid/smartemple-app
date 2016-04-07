//
//  NewsTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "NewsTableViewCell.h"
#import "smartemple.pch"
#import "UIImageView+WebCache.h"
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
    
    
    self.newsimage = [[UIImageView alloc]init];
    [self.newsimage setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.newsimage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.newsimage.clipsToBounds  = YES;
    [self.contentView addSubview:self.newsimage];
    
    self.titleLabel = [[UILabel alloc]init];
    self.titleLabel.font = TextFont;
    self.titleLabel.textColor = [UIColor colorWithRed:83/255.0 green:83/255.0 blue:83/255.0 alpha:1.0];
    [self.contentView addSubview:self.titleLabel];
    
    self.descriptionLabel = [[UILabel alloc]init];
    self.descriptionLabel.font = TextFont;
    self.descriptionLabel.numberOfLines = 0;
    [self.contentView addSubview:self.descriptionLabel];
    
    self.viewLabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.viewLabel];
    
    self.fengexianview = [[UIView alloc]init];
    self.fengexianview.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [self.contentView addSubview:self.fengexianview];
    
    return self;
    
}

- (void)layoutSubviews{
    
    self.newsimage.frame = CGRectMake(5, 5, wScreen/3-10, wScreen/3-10);
    self.titleLabel.frame = CGRectMake(wScreen/3+5, 5,wScreen*2/3-5, 20);
    
    CGSize textSize = [self sizeWithText:self.descriptionLabel.text font:TextFont maxSize:CGSizeMake(wScreen-wScreen/3-15, MAXFLOAT)];
    
    
    [self.descriptionLabel setFrame:CGRectMake(wScreen/3+5,30,wScreen-wScreen/3-10,textSize.height)];
        
    
    
    if (textSize.height<wScreen/3) {
        
        self.fengexianview.frame = CGRectMake(5,wScreen/3, wScreen-10,0.5);
        self.viewLabel.frame = CGRectMake(wScreen/3+5,wScreen/3-25,wScreen*2/3-5,20);
    }else{
        self.fengexianview.frame = CGRectMake(5,textSize.height+30, wScreen-10,0.5);
        self.viewLabel.frame = CGRectMake(wScreen/3+5,textSize.height-25,wScreen*2/3-5,20);
    }
    
    
    
}

- (void)setup:(NewsModel *)model{
    
    
    [self.newsimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.thumb]] placeholderImage:[UIImage imageNamed:@"shareImg.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.newsimage setImage:self.newsimage.image];
    }];
    self.titleLabel.text = model.title;
    self.viewLabel.text = [NSString stringWithFormat:@"已有%@人关注",model.views];
    self.descriptionLabel.text = model.Description;
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
