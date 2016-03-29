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
//    self.templeimage.contentMode =  UIViewContentModeScaleAspectFill;
    self.templeimage.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    self.templeimage.clipsToBounds  = YES;
    [self.contentView addSubview:self.templeimage];
    
    self.templename = [[UILabel alloc]init];
    self.templename.textColor = [UIColor blackColor];
    self.templename.font = NameFont;
    [self.contentView addSubview:self.templename];
    
    self.masterimage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.masterimage];
    
//    self.mastername = [[UILabel alloc]init];
//    self.mastername.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
//    self.mastername.font = TextFont;
//    [self.contentView addSubview:self.mastername];
    
//    self.timelabel = [[UILabel alloc]init];
//    [self.contentView addSubview:self.timelabel];
//    
//    self.provincelabel = [[UILabel alloc]init];
//    self.provincelabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
//    self.provincelabel.font = TextFont;
//    [self.contentView addSubview:self.provincelabel];
//    
//    
//    self.citylabel = [[UILabel alloc]init];
//    self.citylabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
//    self.citylabel.font = TextFont;
//    [self.contentView addSubview:self.citylabel];
    
    
    self.fengexian = [[UIView alloc]init];
    [self.contentView addSubview:self.fengexian];
    
    
    self.guanzhuimage = [[UIImageView alloc]init];
    [self addSubview:self.guanzhuimage];
    self.guanzhulabel = [[UILabel alloc]init];
    self.guanzhulabel.textAlignment = NSTextAlignmentLeft;
    self.guanzhulabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.guanzhulabel.font = [UIFont systemFontOfSize:10];
    [self addSubview:self.guanzhulabel];
   
    
    self.websitelabel = [[UILabel alloc]init];
    self.websitelabel.textAlignment = NSTextAlignmentLeft;
    self.websitelabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.websitelabel.font = TextFont;
    self.websitelabel.numberOfLines = 0;
    [self.contentView addSubview:self.websitelabel];

    
    
    return self;
    
}

- (void)layoutSubviews{
    
    CGSize textSize = [self sizeWithText:self.websitelabel.text font:TextFont maxSize:CGSizeMake(wScreen-20, MAXFLOAT)];
    
    CGSize guanzhuSize = [self sizeWithText:self.guanzhulabel.text font:TextFont maxSize:CGSizeMake(MAXFLOAT,10)];
    
    [self.websitelabel setFrame:CGRectMake(10, wScreen/2+50+wScreen/10, wScreen-20,textSize.height)];
    
    
    self.guanzhuimage.frame = CGRectMake(wScreen-guanzhuSize.width-25, wScreen/2+25+wScreen/10, 10, 10);
    self.guanzhulabel.frame = CGRectMake(wScreen-guanzhuSize.width-10, wScreen/2+20+wScreen/10,guanzhuSize.width, 20);
    
    
    self.masterimage.frame = CGRectMake(wScreen/2-wScreen/10-10,10,wScreen/5,wScreen/5);
    self.templeimage.frame = CGRectMake(10,wScreen/10+10, wScreen-20,wScreen/2);

    self.templename.frame = CGRectMake(10,wScreen/2+20+wScreen/10,wScreen-20,20);
    
    self.masterimage.layer.masksToBounds = YES;
    self.masterimage.layer.cornerRadius = self.masterimage.frame.size.width/2;
    
    //头像边框
    self.masterimage.layer.borderColor = [UIColor whiteColor].CGColor;
    self.masterimage.layer.borderWidth = 2.0;
    
    self.fengexian.frame = CGRectMake(10,wScreen/2+65+textSize.height+wScreen/10,wScreen-20,0.5);
    self.fengexian.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
}

- (void)setup:(TempleModel *)model{
    

    self.templename.text = [NSString stringWithFormat:@"%@(%@ %@)",model.name,model.province,model.city];
    
    
    [self.masterimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.avatar]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.masterimage setImage:self.masterimage.image];
        
    }];

    
    

    [self.templeimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.homeimg]] placeholderImage:[UIImage imageNamed:@"myBackImg@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        
    }];
    
    self.guanzhuimage.image  =[UIImage imageNamed:@"xin.png"];
    
    if (model.views==NULL) {
        self.guanzhulabel.text = @"0";
    }else{
          self.guanzhulabel.text = model.views;
    }
    
  
    
    self.websitelabel.text = model.website;
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
