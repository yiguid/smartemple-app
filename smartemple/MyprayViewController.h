//
//  MyprayViewController.h
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TempleModel.h"
@interface MyprayViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView * tableView;

@property(nonatomic,strong) TempleModel * temple;


@end
