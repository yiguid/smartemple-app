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
#import "UIImageView+WebCache.h"

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
    
    
    UIColor * color =[UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
//                                   initWithTitle:@"左按钮"
//                                   style:UIBarButtonItemStylePlain
//                                   target:self
//                                   action:@selector(left)];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
//    
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
//                                    initWithTitle:@"右按钮"
//                                    style:UIBarButtonItemStylePlain
//                                    target:self
//                                    action:@selector(right)];
//    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];

     self.navigationItem.title = @"我的";
    [self setHeaderView];
    [self loadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadData{
    
    
    
    
}

- (void)setHeaderView{
    
    UIView * headView = [[UIView alloc]init];
    
    headView.frame = CGRectMake(0, 0, wScreen,wScreen/3+50);
    
    self.tableView.tableHeaderView = headView;
    
    UIImageView *  backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,wScreen,wScreen/3)];

    backimage.image = [UIImage imageNamed:@"myBackImg@2x.png"];
    
    [backimage setImage:backimage.image];
    
    [headView addSubview:backimage];
    
    UIImageView * userimage = [[UIImageView alloc]initWithFrame:CGRectMake(wScreen/2-30,wScreen/3-30,60, 60)];
   
    
    [userimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@""]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        [userimage setImage:userimage.image];
        
        userimage.layer.masksToBounds = YES;
        userimage.layer.cornerRadius = userimage.frame.size.width/2;
        
        //头像边框
        userimage.layer.borderColor = [UIColor whiteColor].CGColor;
        userimage.layer.borderWidth = 2.0;
        
    }];
    [headView addSubview:userimage];
    
//    UILabel * temple = [[UILabel alloc]initWithFrame:CGRectMake(20, wScreen/3+40,100,20)];
//    temple.text = @"我的寺院";
//    [headView addSubview:temple];
   
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, wScreen/3+50,wScreen-20,0.5)];
    view.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
    [headView addSubview:view];
    
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
        cell = [[UserTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:ID];
    }
    
    
    if (indexPath.row == 0) {
        cell.menuimage.image = [UIImage imageNamed:@"定格@2x.png"];
        cell.menuname.text = @"我的关注";
        cell.menulabel.text = @">";
    
    }else if (indexPath.row==1){
    
        cell.menuimage.image = [UIImage imageNamed:@"推荐电影@2x.png"];
        
        cell.menuname.text = @"我的捐助";
        cell.menulabel.text = @">";
    
    }else if (indexPath.row==2){
        cell.menuimage.image = [UIImage imageNamed:@"粉丝@3x.png"];

        cell.menuname.text = @"我的祈福";
        cell.menulabel.text = @">";
        
    }else if (indexPath.row==3){
        cell.menuimage.image = [UIImage imageNamed:@"收藏@2x.png"];

        cell.menuname.text = @"我的活动";
        cell.menulabel.text = @">";
        
    }else if (indexPath.row==4){
        cell.menuimage.image = [UIImage imageNamed:@"影品@2x.png"];

        cell.menuname.text = @"我的义工";
        cell.menulabel.text = @">";
        
    }else if (indexPath.row==5){
        cell.menuimage.image = [UIImage imageNamed:@"消息@2x.png"];

        cell.menuname.text = @"消息";
        cell.menulabel.text = @">";
        
    }else if (indexPath.row==6){
        cell.menuimage.image = [UIImage imageNamed:@"设置@2x.png"];

        cell.menuname.text = @"设置";
        cell.menulabel.text = @">";
        
    }
    cell.selectionStyle =UITableViewCellSelectionStyleNone;

  
    return  cell;
    
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 50;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row==0) {
        MyattentViewController * myattent = [[MyattentViewController alloc]init];
        
        myattent.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:myattent animated:YES];
    }else if (indexPath.row==1) {
        MydonateViewController * mydonate = [[MydonateViewController alloc]init];
        
        mydonate.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:mydonate animated:YES];
    }else if (indexPath.row==2) {
        MyprayViewController * mypray = [[MyprayViewController alloc]init];
        
        mypray.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:mypray animated:YES];
    }else if (indexPath.row==3) {
        MyactivityViewController * myactivity = [[MyactivityViewController alloc]init];
        
        myactivity.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:myactivity animated:YES];
    }else if (indexPath.row==4) {
        MyattentViewController * myattent = [[MyattentViewController alloc]init];
        
        myattent.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:myattent animated:YES];
    }else if (indexPath.row==5) {
        MyworkViewController * mywork = [[MyworkViewController alloc]init];
        
        mywork.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:mywork animated:YES];
    }else if (indexPath.row==6) {
        MysettingViewController * mysetting = [[MysettingViewController alloc]init];
        
        mysetting.hidesBottomBarWhenPushed = YES;
        
        [self.navigationController pushViewController:mysetting animated:YES];
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
