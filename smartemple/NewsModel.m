//
//  NewsModel.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "NewsModel.h"
#import "smartemple.pch"

@implementation NewsModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"Description" : @"description",@"newsID":@"id"};
}

-(CGFloat)getCellHeight{
    CGSize textSize = [self sizeWithText:self.Description font:TextFont maxSize:CGSizeMake(wScreen-wScreen/3-15, MAXFLOAT)];
    
    if (textSize.height<wScreen/3) {
        return wScreen/3;
    }else{
         return textSize.height + 30;
    }
    
    
   
}


-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}



@end
