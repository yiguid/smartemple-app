//
//  TempleTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "TempleTableViewCell.h"
#import "smartemple.pch"
#import "UIImageView+WebCache.h"

@implementation TempleTableViewCell

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
    self.templeimage.contentMode =  UIViewContentModeScaleAspectFill;
    self.templeimage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.templeimage.clipsToBounds  = YES;
    [self.contentView addSubview:self.templeimage];
    
    self.templename = [[UILabel alloc]init];
    self.templename.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.templename.font = TextFont;
    [self.contentView addSubview:self.templename];
    
    self.masterimage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.masterimage];
    
    self.mastername = [[UILabel alloc]init];
    self.mastername.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.mastername.font = TextFont;
    [self.contentView addSubview:self.mastername];
    
    self.timelabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.timelabel];
    
    self.provincelabel = [[UILabel alloc]init];
    self.provincelabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.provincelabel.font = TextFont;
    [self.contentView addSubview:self.provincelabel];
    
    
    self.citylabel = [[UILabel alloc]init];
    self.citylabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.citylabel.font = TextFont;
    [self.contentView addSubview:self.citylabel];
    
   
    
    
    return self;
    
}

- (void)layoutSubviews{
    
    
    self.templeimage.frame = CGRectMake(10, 10, wScreen-20,200);
    self.masterimage.frame = CGRectMake(10, 250,30,30);
    self.mastername.frame = CGRectMake(50, 260, 100, 20);
    self.provincelabel.frame = CGRectMake(10, 220,50, 20);
    self.citylabel.frame = CGRectMake(50, 220,80, 20);
    self.templename.frame = CGRectMake(100, 220,50, 20);
    
    self.masterimage.layer.masksToBounds = YES;
    self.masterimage.layer.cornerRadius = self.masterimage.frame.size.width/2;
    
    
  
}

- (void)setup:(TempleModel *)model{
    
    self.provincelabel.text = model.province;
    self.templename.text = model.name;
    self.citylabel.text = model.city;
    self.mastername.text = model.master;
    [self.masterimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.avatar]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.masterimage setImage:self.masterimage.image];
        //头像圆形
       
    }];

    [self.templeimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.homeimg]] placeholderImage:[UIImage imageNamed:@"myBackImg@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
