//
//  Questionmodel.m
//  smartemple
//
//  Created by wang on 16/3/7.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "Questionmodel.h"
#import "smartemple.pch"
@implementation Questionmodel

-(CGFloat)getCellHeight{
    CGSize anwserSize = [self sizeWithText:self.answer font:TextFont maxSize:CGSizeMake(wScreen - 20, MAXFLOAT)];
    CGSize questionSize = [self sizeWithText:self.question font:TextFont maxSize:CGSizeMake(wScreen - 20, MAXFLOAT)];
    
    return anwserSize.height+questionSize.height+30;
}


-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
