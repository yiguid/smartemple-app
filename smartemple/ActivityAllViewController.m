//
//  ActivityAllViewController.m
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "ActivityAllViewController.h"
#import "smartemple.pch"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "ActiviTableViewCell.h"
#import "ActiviModel.h"
#import "ActivitySecondViewController.h"
@interface ActivityAllViewController ()
@property(nonatomic, strong)NSMutableArray * ActivityArr;

@end

@implementation ActivityAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.ActivityArr = [[NSMutableArray alloc]init];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    [self loadActivity];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadActivity{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"templeid":self.temple.templeid,@"page":@"1",@"limit":@"15",@"access_token":token};
    NSString *url = [NSString stringWithFormat:@"%@/activity",Temple_API];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.ActivityArr = [ActiviModel mj_objectArrayWithKeyValuesArray:responseObject];
        
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.ActivityArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *ID = [NSString stringWithFormat:@"ActivityCell"];
    ActiviTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[ActiviTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    [cell setup:self.ActivityArr[indexPath.row]];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActiviModel *model = [self.ActivityArr objectAtIndex:indexPath.row];
    return [model getCellHeight];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ActivitySecondViewController * activity = [[ActivitySecondViewController alloc]init];
    ActiviModel *model = [self.ActivityArr objectAtIndex:indexPath.row];
    activity.activityID = model.activityID;
    activity.templeID = self.temple.templeid;
    activity.type = model.type;
    activity.activityString = @"temple";
    [self.navigationController pushViewController:activity animated:YES];
    
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
