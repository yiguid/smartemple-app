//
//  MasterSectionViewController.h
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "masterModel.h"
@interface MasterSectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UITextViewDelegate>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) masterModel * master;

@property(nonatomic, strong) UIView *textView;
@property(nonatomic, strong) UITextView *textFiled;
@property(nonatomic, strong) UIButton *textButton;

@end
