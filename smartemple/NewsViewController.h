//
//  NewsViewController.h
//  smartemple
//
//  Created by wang on 16/3/4.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewsViewController : UIViewController<UIWebViewDelegate>


@property(nonatomic,strong) NSString * newsID;
@property(nonatomic,strong) NSString * templeID;
@property(nonatomic,strong) NSString * type;
@property(nonatomic,strong) NSString * newsString;


@end
