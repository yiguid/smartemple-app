//
//  ActiviModel.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "ActiviModel.h"
#import "smartemple.pch"

@implementation ActiviModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"Description" : @"description",@"activityID":@"id"};
}

-(CGFloat)getCellHeight{
    CGSize textSize = [self sizeWithText:self.title font:TextFont maxSize:CGSizeMake(wScreen -100, MAXFLOAT)];
    
    
    return textSize.height+30;
}


-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
