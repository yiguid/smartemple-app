//
//  Timelinemodel.m
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Timelinemodel.h"
#import "smartemple.pch"
@implementation Timelinemodel

-(CGFloat)getCellHeight{
    CGSize textSize = [self sizeWithText:self.message font:TextFont maxSize:CGSizeMake(wScreen - 80, MAXFLOAT)];
    
    
    return textSize.height + 55;
}


-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
