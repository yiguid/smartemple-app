//
//  TempleModel.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "TempleModel.h"
#import "smartemple.pch"
@implementation TempleModel

-(CGFloat)getCellHeight{
    CGSize textSize = [self sizeWithText:self.website font:TextFont maxSize:CGSizeMake(wScreen - 20, MAXFLOAT)];
    
    
    return textSize.height + wScreen/2+65;
}


-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
