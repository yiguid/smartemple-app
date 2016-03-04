//
//  TempleViewController.h
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TempleViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchDisplayDelegate>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,retain)UISearchDisplayController *searchController;

@end
