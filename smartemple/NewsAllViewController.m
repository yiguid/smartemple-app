//
//  NewsAllViewController.m
//  smartemple
//
//  Created by wang on 16/3/10.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "NewsAllViewController.h"
#import "smartemple.pch"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "NewsTableViewCell.h"
#import "NewsModel.h"
#import "NewsViewController.h"
@interface NewsAllViewController ()
@property(nonatomic, strong)NSMutableArray * NewsArr;
@end

@implementation NewsAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.NewsArr = [[NSMutableArray alloc]init];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    [self loadNews];

}

-(void)loadNews{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters = @{@"templeid":self.temple.templeid,@"page":@"1",@"limit":@"15",@"access_token":token};
    NSString *url = [NSString stringWithFormat:@"%@/news",Temple_API];
    [manager GET:url parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.NewsArr = [NewsModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        
        
        [self.tableView reloadData];
        
        NSLog(@"请求成功");
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
        return self.NewsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
        NSString *ID = [NSString stringWithFormat:@"NewsCell"];
        NewsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[NewsTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
        }
        
        
        [cell setup:self.NewsArr[indexPath.row]];
        cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
        return cell;
  }


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
            
        NewsModel *model = [self.NewsArr objectAtIndex:indexPath.row];
        return [model getCellHeight];
        
    }

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NewsViewController * news = [[NewsViewController alloc]init];
    NewsModel * model = [self.NewsArr objectAtIndex:indexPath.row];
    news.newsID = model.newsID;
    news.templeID = self.temple.templeid;
    [self.navigationController pushViewController:news animated:YES];

    
    
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
