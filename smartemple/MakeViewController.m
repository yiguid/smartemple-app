//
//  MakeViewController.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MakeViewController.h"
#import "smartemple.pch"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "TempleModel.h"
#import "masterModel.h"
#import "NewsModel.h"
#import "ActiviModel.h"
#import "TempleTableViewCell.h"
#import "TempleSecondViewController.h"
#import "MasterCollectionViewCell.h"
#import "MasterSectionViewController.h"
#import "MasterTableViewCell.h"
#import "NewsTableViewCell.h"
#import "ActiviTableViewCell.h"
#import "NewsViewController.h"
@interface MakeViewController ()

@property(nonatomic, strong)NSMutableArray * templeMakeArr;
@property(nonatomic, strong)NSMutableArray * masterMakeArr;
@property(nonatomic, strong)NSMutableArray * newsMakeArr;
@property(nonatomic, strong)NSMutableArray * activityMakeArr;

@end

@implementation MakeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    self.templeMakeArr = [[NSMutableArray alloc]init];
    self.masterMakeArr = [[NSMutableArray alloc]init];
    self.newsMakeArr = [[NSMutableArray alloc]init];
    self.activityMakeArr = [[NSMutableArray alloc]init];

    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
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
    
     self.navigationItem.title = @"发现";
    
    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)loadData{

        
        AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        
        [manager GET:Make_recTemple_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            self.templeMakeArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"find"]];
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
        
        [manager GET:Make_recMaster_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            self.masterMakeArr = [masterModel mj_objectArrayWithKeyValuesArray:responseObject[@"find"]];
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
        
        [manager GET:Make_news_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            self.newsMakeArr = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"find"]];
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
    
        [manager GET:Make_activity_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"%@",responseObject);
            
            self.activityMakeArr = [ActiviModel mj_objectArrayWithKeyValuesArray:responseObject[@"find"]];
            [self.tableView reloadData];
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
            
            
        }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 4;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return self.templeMakeArr.count;
    } else if (section==1){
        
        return self.masterMakeArr.count;
    }
    else if (section==2){
        
        return self.newsMakeArr.count;
    }else{
        
        return self.activityMakeArr.count;
    }

    
   
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    
    if (indexPath.section==0) {
        NSString *ID = [NSString stringWithFormat:@"Cell"];
        TempleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[TempleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
    [cell setup:self.templeMakeArr[indexPath.row]];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
    }else  if (indexPath.section==1) {
        
        
        NSString *ID = [NSString stringWithFormat:@"MasterCell"];
        MasterTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[MasterTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        
        [cell setup:self.masterMakeArr[indexPath.row]];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
        
        
        
        
        
    }else  if (indexPath.section==2) {
        
        
        NSString *ID = [NSString stringWithFormat:@"NewsCell"];
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        
        [cell setup:self.newsMakeArr[indexPath.row]];
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;

        
        
        
        
    }else{
        
        
        NSString *ID = [NSString stringWithFormat:@"ActivityCell"];
        ActiviTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[ActiviTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        
        [cell setup:self.activityMakeArr[indexPath.row]];
         cell.selectionStyle =UITableViewCellSelectionStyleNone;
        return cell;

        
        
        
    }
    
    return nil;
    
    
    
    
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        TempleModel *model = [self.templeMakeArr objectAtIndex:indexPath.row];
        return [model getCellHeight];
        
    }else if (indexPath.section==1){
        
        return wScreen/5+20;
    }else if (indexPath.section==2){
    
        return 80;
    }else{
        return 80;
    }
    
    
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{

    if (section==0) {
        return @"寺院";
    }else if (section==1){
        return @"法师";
    }else if (section==2){
        return @"消息";
    }else{
        return @"活动";
    }

}



-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.section==0) {
        
        TempleSecondViewController * temple = [[TempleSecondViewController alloc]init];
        TempleModel * model = self.templeMakeArr[indexPath.row];
        
        temple.temple = model;
        
        temple.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        

        [self.navigationController pushViewController:temple animated:YES];
        
    }else if (indexPath.section==1){
        
        MasterSectionViewController * master = [[MasterSectionViewController alloc]init];
        masterModel * model = self.masterMakeArr[indexPath.row];
        
        master.master = model;
        
        master.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;

        [self.navigationController pushViewController:master animated:YES];
        
    }else if (indexPath.section==2){
        
        NewsViewController * news = [[NewsViewController alloc]init];
        news.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:news animated:YES];
    
    }else{
                
    
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
