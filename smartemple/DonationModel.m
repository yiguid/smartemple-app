//
//  DonationModel.m
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "DonationModel.h"
#import "smartemple.pch"
@implementation DonationModel

+(NSDictionary *)replacedKeyFromPropertyName
{
    return @{@"Description" : @"description",@"donationID":@"id"};
}
-(CGFloat)getCellHeight{
    CGSize textSize = [self sizeWithText:self.Description font:TextFont maxSize:CGSizeMake(hScreen-wScreen/3-15, MAXFLOAT)];
    
    
    return textSize.height + 30;
}


-(CGSize)sizeWithText:(NSString *)text font:(UIFont *)font maxSize:(CGSize)maxSize{
    NSDictionary *attrs = @{NSFontAttributeName : font};
    return  [text boundingRectWithSize: maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
}


@end
