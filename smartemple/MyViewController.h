//
//  MyViewController.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;

@end
