//
//  WishTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "WishTableViewCell.h"
#import "smartemple.pch"
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
    self.username.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    self.username.textColor = [UIColor whiteColor];
    self.username.font = TextFont;
    self.username.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.username];
    
    self.address = [[UILabel alloc]init];
    self.address.font = TextFont;
    [self.contentView addSubview:self.address];
    
//    self.datetime = [[UILabel alloc]init];
//    [self.contentView addSubview:self.datetime];
    
    self.messagelabel = [[UILabel alloc]init];
    self.messagelabel.font = TextFont;
    [self.contentView addSubview:self.messagelabel];

    
    self.message = [[UILabel alloc]init];
    self.message.font = TextFont;
    self.message.numberOfLines = 0;
    [self.contentView addSubview:self.message];
    
    self.fengexian = [[UIView alloc]init];
    self.fengexian.backgroundColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    [self.contentView addSubview:self.fengexian];
    
    return self;
    
}

- (void)layoutSubviews{
    
    CGSize textSize = [self sizeWithText:self.message.text font:TextFont maxSize:CGSizeMake(wScreen-55, MAXFLOAT)];
    
    CGSize namesize = [self sizeWithText:self.username.text font:TextFont maxSize:CGSizeMake(MAXFLOAT, 20)];
    
    [self.message setFrame:CGRectMake(45,53, wScreen-55, textSize.height)];
    
    [self.username setFrame:CGRectMake(10, 10, namesize.width+10, 20)];
    
    self.address.frame = CGRectMake(15, 30, wScreen-30, 20);
    self.messagelabel.frame = CGRectMake(15,50,30,20);
   
    self.fengexian.frame = CGRectMake(10,textSize.height+60, wScreen-20,0.5);
    

}

- (void)setup:(Wishmodel *)model{
    
    self.username.text = model.userid;
    
    self.address.text = [NSString stringWithFormat:@"[来自%@ %@]",model.location,model.datetime];
    self.messagelabel.text = @"留言:";
    self.message.text = model.content;
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}




@end
