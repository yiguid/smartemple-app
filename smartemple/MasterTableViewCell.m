//
//  MasterTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/9.
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
    
    self.userimage = [[UIImageView alloc] init];
    [self addSubview:self.userimage];
    self.title = [[UILabel alloc]init];
    self.title.textAlignment = NSTextAlignmentLeft;
    self.title.font = NameFont;
//    self.title.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [self addSubview:self.title];
    self.renqilabel = [[UILabel alloc]init];
    self.renqilabel.font = TextFont;
    self.renqilabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [self addSubview:self.renqilabel];
    self.guanzhulabel = [[UILabel alloc]init];
    self.guanzhulabel.textAlignment = NSTextAlignmentLeft;
    self.guanzhulabel.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.guanzhulabel.font = TextFont;
    [self addSubview:self.guanzhulabel];
    
    self.fengexian = [[UIView alloc]init];
    self.fengexian.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [self.contentView addSubview:self.fengexian];

    
    
    return self;
    
}

- (void)layoutSubviews{
    
    self.userimage.frame = CGRectMake(10,10,wScreen/5,wScreen/5);
    self.title.frame = CGRectMake(wScreen/5+20,15,100, 20);
    
    self.renqilabel.frame = CGRectMake(wScreen/5+70,35,50,30);
    self.guanzhulabel.frame = CGRectMake(wScreen/5+20,35,50,30);
    
    self.fengexian.frame = CGRectMake(10,wScreen/5+20,wScreen-20,0.5);

    
    //头像圆形
    self.userimage.layer.masksToBounds = YES;
    self.userimage.layer.cornerRadius = self.userimage.frame.size.width/2;
    
}

- (void)setup:(masterModel *)model{
    
    [self.userimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://smartemple.com/%@",model.avatar]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.userimage setImage:self.userimage.image];
        
    }];
    
    self.title.text = model.realname;
    
    self.renqilabel.text =  [NSString stringWithFormat:@"人气 %@",model.views];
    
    if (model.likes==NULL) {
        self.guanzhulabel.text =  [NSString stringWithFormat:@"关注 0"];
    }else{
        self.guanzhulabel.text =  [NSString stringWithFormat:@"关注 %@",model.likes];
    }

    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



@end
