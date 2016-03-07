//
//  MasterSectionViewController.h
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "masterModel.h"
@interface MasterSectionViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;
//@property(nonatomic, strong) UITableView *timelinetableview;
//@property(nonatomic, strong) UITableView *questiontableview;
//@property(nonatomic, strong) UITableView *wishtableview;

@property(nonatomic,strong) masterModel * master;

@end
