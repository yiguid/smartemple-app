//
//  Wishmodel.m
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Wishmodel.h"
#import "smartemple.pch"
@implementation Wishmodel

-(CGFloat)getCellHeight{
    CGSize textSize = [self sizeWithText:self.content font:TextFont maxSize:CGSizeMake(wScreen - 55, MAXFLOAT)];
    
    return textSize.height+60;
}


-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}

@end
