//
//  MyViewController.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MyViewController.h"
#import "smartemple.pch"
#import "UserModel.h"
#import "UserTableViewCell.h"
#import "MyattentViewController.h"
#import "MydonateViewController.h"
#import "MyprayViewController.h"
#import "MyactivityViewController.h"
#import "MyworkViewController.h"
#import "MynewsViewController.h"
#import "MysettingViewController.h"
@interface MyViewController ()

@end

@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];

     self.navigationItem.title = @"我的";
    
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    
    
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *ID = [NSString stringWithFormat:@"Cell"];
    UserTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    if (indexPath.row == 0) {
        cell.menuname.text = @"我的关注";
    
    }else if (indexPath.row==1){
    
        cell.menuname.text = @"我的捐助";
    
    }else if (indexPath.row==2){
        
        cell.menuname.text = @"我的祈福";
        
    }else if (indexPath.row==3){
        
        cell.menuname.text = @"我的活动";
        
    }else if (indexPath.row==4){
        
        cell.menuname.text = @"我的义工";
        
    }else if (indexPath.row==5){
        
        cell.menuname.text = @"消息";
        
    }else if (indexPath.row==6){
        
        cell.menuname.text = @"设置";
        
    }
  
    
    return  cell;
    
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 80;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    
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
