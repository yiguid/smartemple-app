//
//  WishTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "WishTableViewCell.h"
#import "smartemple.pch"
#import "UIImageView+WebCache.h"
@implementation WishTableViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    
    self.username = [[UILabel alloc]init];
    self.username.textColor =  [UIColor colorWithRed:91/255.0 green:108/255.0 blue:121/255.0 alpha:1.0];
    self.username.font = TextFont;
    self.username.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.username];
    
//    self.address = [[UILabel alloc]init];
//    self.address.font = TextFont;
//    [self.contentView addSubview:self.address];
    
    self.datetime = [[UILabel alloc]init];
    self.datetime.font = TimeFont;
    self.datetime.textColor = [UIColor colorWithRed:184.0/255 green:188.0/255 blue:194.0/255 alpha:1.0];
    [self.contentView addSubview:self.datetime];
    
    self.message = [[UILabel alloc]init];
    self.message.font = TextFont;
    self.message.numberOfLines = 0;
    [self.contentView addSubview:self.message];
    
    self.donationcontent = [[UILabel alloc]init];
    self.donationcontent.font = TextFont;
    self.donationcontent.textColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.donationcontent.numberOfLines = 0;
    [self.contentView addSubview:self.donationcontent];
    
    self.userimage = [[UIImageView alloc]init];
    
    [self.contentView addSubview:self.userimage];
    
    self.fengexian = [[UIView alloc]init];
    [self.contentView addSubview:self.fengexian];
    
    return self;
    
}

- (void)layoutSubviews{
    
    CGSize textSize = [self sizeWithText:self.message.text font:TextFont maxSize:CGSizeMake(wScreen-55, MAXFLOAT)];
    
    CGSize namesize = [self sizeWithText:self.username.text font:TextFont maxSize:CGSizeMake(MAXFLOAT, 20)];
    
    CGSize donsize = [self sizeWithText:self.donationcontent.text font:TextFont maxSize:CGSizeMake(wScreen-30, MAXFLOAT)];
    
    [self.message setFrame:CGRectMake(55,33, wScreen-65, textSize.height)];
    
    [self.username setFrame:CGRectMake(55, 10,namesize.width, 20)];
    
    self.datetime.frame = CGRectMake(55,textSize.height+45+donsize.height,200, 20);
    self.donationcontent.frame = CGRectMake(55, textSize.height+40, wScreen-70,donsize.height);
   
    self.fengexian.frame = CGRectMake(10,textSize.height+65+donsize.height, wScreen-20,0.5);
    self.fengexian.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.userimage.frame = CGRectMake(10,10, 40, 40);
    
    //头像圆形
    self.userimage.layer.masksToBounds = YES;
    self.userimage.layer.cornerRadius = self.userimage.frame.size.width/2;

}

- (void)setup:(Wishmodel *)model{
    
    self.username.text = model.realname;
    
    self.datetime.text = model.datetime;
    self.message.text = model.content;
    
    if (model.donationcontent==NULL) {
        self.donationcontent.text = nil;
    }else{
        
        self.donationcontent.text = model.donationcontent;
    
    }
   
    [self.userimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://temple.irockwill.com/userimg/avatar/%@",model.avatar]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [self.userimage setImage:self.userimage.image];
    }];

    

}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}




@end
