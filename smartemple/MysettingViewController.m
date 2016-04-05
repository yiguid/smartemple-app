//
//  MysettingViewController.m
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MysettingViewController.h"
#import "smartemple.pch"
#import "TempleModel.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "AppDelegate.h"
@interface MysettingViewController ()

@end

@implementation MysettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    UIButton *signOut = [[UIButton alloc]initWithFrame:CGRectMake(20,hScreen*3/4, self.view.frame.size.width - 40,40)];
    [signOut setTitle:@"退出登录" forState:UIControlStateNormal];
//    [self modifyUIButton:signOut];
    [signOut addTarget:self action:@selector(loginOut) forControlEvents:UIControlEventTouchUpInside];
    [signOut setTitleColor:[UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0] forState:UIControlStateNormal];
    CGColorSpaceRef colorSpaceRef = CGColorSpaceCreateDeviceRGB();
    
    CGColorRef color = CGColorCreate(colorSpaceRef, (CGFloat[]){147/255.0,133/255.0,99/255.0,1});
    [signOut.layer setMasksToBounds:YES];//设置按钮的圆角半径不会被遮挡
    
    [signOut.layer setCornerRadius:10];
    
    [signOut.layer setBorderWidth:2];//设置边界的宽度
    [signOut.layer setBorderColor:color];
    [self.view addSubview:signOut];

}

//- (void)modifyUIButton: (UIButton *) button {
//    button.backgroundColor = [UIColor whiteColor];
//    CGRect rect = button.frame;
//    rect.size.height = 40;
//    button.frame = rect;
//    button.layer.cornerRadius = 6.0;
//}

- (void)loginOut{
    //清空user defaults
    NSDictionary *defaultsDictionary = [[NSUserDefaults standardUserDefaults] dictionaryRepresentation];
    for (NSString *key in [defaultsDictionary allKeys])
    {
        NSLog(@"%@",key);
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:key];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    CATransition *animation = [CATransition animation];
    [animation setDuration:1.0];
    [animation setType:kCATransitionFade]; //淡入淡出kCATransitionFade
    [animation setSubtype:kCATransitionFromRight];
    [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionDefault]];
    [[UIApplication sharedApplication].keyWindow.layer addAnimation:animation forKey:nil];
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *loginVC = [mainStoryboard instantiateViewControllerWithIdentifier:@"LoginScene"];
    self.view.window.rootViewController = loginVC;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 计算缓存大小
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //#warning Incomplete implementation, return the number of sections
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    //#warning Incomplete implementation, return the number of rows
    if (section == 0) {
        self.tableView.sectionHeaderHeight = 2;
        
        return 3;
    }
    else{
        self.tableView.sectionHeaderHeight = 2;
        
        return 1;
        
        
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *ID = [NSString stringWithFormat:@"cell"];
    
    
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    
    if (indexPath.section==0) {
        if (indexPath.row == 0) {
            cell.textLabel.text = @"清理缓存";
            cell.textLabel.font = TextFont;
            cell.textLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
            cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, wScreen, 1)];
            
            headView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
            
            
            [cell.contentView addSubview:headView];
            
            
            
            SDImageCache * Cache = [[SDImageCache alloc]init];
            
            NSUInteger size = [Cache getSize];
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

            
            
            cell.detailTextLabel.text = [NSString stringWithFormat:@"%luM",size/1024];
            
            cell.detailTextLabel.font = TextFont;
            
        }
        else if(indexPath.row == 1)
        {
            cell.textLabel.text = @"消息提醒";
            cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
            cell.textLabel.font = TextFont;
            cell.textLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
           
            UISwitch *switchButton = [[UISwitch alloc] initWithFrame:CGRectMake(wScreen-60,10, 20, 10)];
            [switchButton setOn:YES];
            [switchButton addTarget:self action:@selector(switchAction:) forControlEvents:UIControlEventValueChanged];
            [cell.contentView addSubview:switchButton];
            
            UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, wScreen, 1)];
            
            headView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
            
            [cell.contentView addSubview:headView];
            
            
            
        }
        else
        {
            cell.textLabel.text = @"修改密码";
            cell.textLabel.font = TextFont;
            cell.textLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
            cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

        }
        
    }else{
        
        cell.textLabel.text = @"关于智慧寺院";
        cell.backgroundColor = [UIColor colorWithRed:229.0/255 green:229.0/255 blue:229.0/255 alpha:1.0];
        cell.textLabel.font = TextFont;
        cell.textLabel.textColor = [UIColor colorWithRed:133/255.0 green:133/255.0 blue:133/255.0 alpha:1.0];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

//        cell.backgroundColor = [UIColor colorWithRed:247/255.0 green:247/255.0 blue:247/255.0 alpha:1.0];
        
    }
    
    
    return cell;
}

-(void)switchAction:(id)sender
{
    UISwitch *switchButton = (UISwitch*)sender;
    BOOL isButtonOn = [switchButton isOn];
    if (isButtonOn) {
        NSLog(@"是");
    }else {
        NSLog(@"否");
    }
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    //隐藏顶部的分割线
    UIView *headView = [[UIView alloc]init];
    
    headView.backgroundColor = [UIColor whiteColor];
    
    
    return headView;
}



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 45;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 1) {
        return 10;
    }else{
        return 0;
    }
    
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIBarButtonItem *back = [[UIBarButtonItem alloc] init];
    back.title = @"";
    self.navigationItem.backBarButtonItem = back;
    if (indexPath.section == 0) {
        if (indexPath.row == 0){
            
            UIAlertView *alert;
            alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"确定清理缓存" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            
            
        }
        
    }
    
    
    
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    if(buttonIndex == 1){
        
        [[SDImageCache sharedImageCache] clearDisk];
        
        [[SDImageCache sharedImageCache] clearMemory];//可有可无
        
        
        
        
        [self.tableView reloadData];
        
        
        NSLog(@"内存清理成功");
        
        [self.tableView reloadData];
        
    }
    
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
