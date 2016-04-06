//
//  WishAllViewController.h
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleModel.h"

@interface WishAllViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) TempleModel * temple;

@property(nonatomic, strong) UIView *textView;
@property(nonatomic, strong) UITextView *textFiled;
@property(nonatomic, strong) UIButton *textButton;

@end
