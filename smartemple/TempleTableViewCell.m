//
//  TempleTableViewCell.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "TempleTableViewCell.h"
#import "smartemple.pch"
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
    [self.contentView addSubview:self.templeimage];
    
    self.masterimage = [[UIImageView alloc]init];
    [self.contentView addSubview:self.masterimage];
    
    self.mastername = [[UILabel alloc]init];
    [self.contentView addSubview:self.mastername];
    
    self.timelabel = [[UILabel alloc]init];
    [self.contentView addSubview:self.timelabel];
    
   
    
    

    
        
    
    return self;
    
}

- (void)layoutSubviews{
    
    
    self.templeimage.frame = CGRectMake(10, 10, wScreen-20, 200);
    self.masterimage.frame = CGRectMake(10, 220,30,30);
    self.mastername.frame = CGRectMake(50, 230, 100, 20);
    
  
}

- (void)setup:(TempleModel *)model{
    
    
    
}

-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
