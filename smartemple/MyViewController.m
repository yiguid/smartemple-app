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
#import "MyattentViewController.h"
#import "MydonateViewController.h"
#import "MyprayViewController.h"
#import "MyactivityViewController.h"
#import "MyworkViewController.h"
#import "MynewsViewController.h"
#import "MysettingViewController.h"
#import "UIImageView+WebCache.h"
#import "AFNetworking.h"
#import "MJExtension.h"
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
    

    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];

     self.navigationItem.title = @"我的";
    [self setHeaderView];
    
//    self.tableView.backgroundColor = [UIColor colorWithRed:33/255.0 green:32/255.0 blue:48/255.0 alpha:1.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setHeaderView{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSString *userID = [userDef stringForKey:@"userID"];
    NSDictionary *parameters = @{@"userid":userID,@"access_token":token};
    [manager GET:My_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
     
        
//         [userimage addTarget:self action:@selector(userimageButton)forControlEvents:UIControlEventTouchUpInside];
        
        UIView * headView = [[UIView alloc]init];
        
        headView.frame = CGRectMake(0, 0, wScreen,wScreen/2);
//        headView.backgroundColor = [UIColor colorWithRed:33/255.0 green:32/255.0 blue:48/255.0 alpha:1.0];
        self.tableView.tableHeaderView = headView;
        
        UIImageView *  backimage = [[UIImageView alloc]initWithFrame:CGRectMake(0,0,wScreen,wScreen/3)];
        
        backimage.image = [UIImage imageNamed:@"myBackImg@2x.png"];
        
        [backimage setImage:backimage.image];
        
        [headView addSubview:backimage];
        
        UILabel * userlabel = [[UILabel alloc]initWithFrame:CGRectMake(10,wScreen/3, wScreen/3, 20)];
        userlabel.text = responseObject[0][@"realname"];
        userlabel.textColor = [UIColor colorWithRed:33/255.0 green:32/255.0 blue:48/255.0 alpha:1.0];
        [headView addSubview:userlabel];
        
        UIButton * userimageBtn = [[UIButton alloc]initWithFrame:CGRectMake(wScreen*5/12,wScreen/4,wScreen/6,wScreen/6)];
        [headView addSubview:userimageBtn];
        UIButton * username = [[UIButton alloc]initWithFrame:CGRectMake(10,wScreen/3, wScreen/3, 20)];
        [headView addSubview:username];
        
        [userimageBtn addTarget:self action:@selector(userimageButton)forControlEvents:UIControlEventTouchUpInside];
        
        [username addTarget:self action:@selector(usernameButton)forControlEvents:UIControlEventTouchUpInside];
        
        
        UIImageView * userimage = [[UIImageView alloc]initWithFrame:CGRectMake(wScreen*5/12,wScreen/4,wScreen/6,wScreen/6)];
        
               [userimage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://temple.irockwill.com/userimg/avatar/%@",responseObject[0][@"avatar"]]] placeholderImage:[UIImage imageNamed:@"avatar@2x.png"] completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
            [userimage setImage:userimage.image];
            
            userimage.layer.masksToBounds = YES;
            userimage.layer.cornerRadius = userimage.frame.size.width/2;
            
            //头像边框
            userimage.layer.borderColor = [UIColor whiteColor].CGColor;
            userimage.layer.borderWidth = 2.0;
            
        }];
        [headView addSubview:userimage];
        
        
        UIView * view = [[UIView alloc]initWithFrame:CGRectMake(10, wScreen/2-1,wScreen-20,0.5)];
        view.backgroundColor = [UIColor colorWithRed:150/255.0 green:150/255.0 blue:150/255.0 alpha:1.0];
        [headView addSubview:view];

        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];

    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    
    return 7;
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UIView *headView = [[UIView alloc]initWithFrame:CGRectMake(0, 44, wScreen, 1)];
    
    headView.backgroundColor = [UIColor colorWithRed:236/255.0 green:236/255.0 blue:236/255.0 alpha:1.0];
    
    
    NSString *ID = [NSString stringWithFormat:@"cell"];
    UITableViewCell *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ID];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    cell.textLabel.font = TextFont;
    [cell.contentView addSubview:headView];
    if (indexPath.row == 0) {
        cell.imageView.image = [UIImage imageNamed:@"定格@2x.png"];
        cell.textLabel.text = @"我的关注";

    }else if (indexPath.row==1){
    
        cell.imageView.image = [UIImage imageNamed:@"推荐电影@2x.png"];
        
        cell.textLabel.text = @"我的捐助";
    
    }else if (indexPath.row==2){
        cell.imageView.image = [UIImage imageNamed:@"粉丝@3x.png"];

        cell.textLabel.text = @"我的祈福";
        
    }else if (indexPath.row==3){
        cell.imageView.image = [UIImage imageNamed:@"收藏@2x.png"];

        cell.textLabel.text = @"我的活动";
        
    }else if (indexPath.row==4){
        cell.imageView.image = [UIImage imageNamed:@"影品@2x.png"];

        cell.textLabel.text = @"我的义工";
        
    }else if (indexPath.row==5){
        cell.imageView.image = [UIImage imageNamed:@"消息@2x.png"];

        cell.textLabel.text = @"消息";
        
    }else if (indexPath.row==6){
        cell.imageView.image = [UIImage imageNamed:@"设置@2x.png"];

        cell.textLabel.text = @"设置";
        
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

-(void)userimageButton{
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"AlertHead"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
    
}

-(void)usernameButton{
    
    
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:@"Alertname"];
    [self.navigationController pushViewController:vc animated:YES];
    
    
    
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
