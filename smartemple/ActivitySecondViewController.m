//
//  ActivitySecondViewController.m
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "ActivitySecondViewController.h"
#import "smartemple.pch"
#import "ActiviModel.h"
#import "ActivitySecondTableViewCell.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
@interface ActivitySecondViewController ()

@end

@implementation ActivitySecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    self.navigationItem.title = @"活动详情";
    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    

    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
  

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
