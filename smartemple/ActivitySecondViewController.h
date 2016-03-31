//
//  ActivitySecondViewController.h
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ActivitySecondViewController : UIViewController<UIWebViewDelegate>


@property(nonatomic,strong) NSString * activityID;
@property(nonatomic,strong) NSString * templeID;
@property(nonatomic,strong) NSString * type;
@property(nonatomic,strong) NSString * activityString;

@end
