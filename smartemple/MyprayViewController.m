//
//  MyprayViewController.m
//  smartemple
//
//  Created by wang on 16/3/3.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "MyprayViewController.h"
#import "smartemple.pch"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
#import "WishTableViewCell.h"
#import "Wishmodel.h"
@interface MyprayViewController ()
@property(nonatomic, strong)NSMutableArray * WishArr;

@end

@implementation MyprayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.WishArr = [[NSMutableArray alloc]init];
    
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    [self loadWish];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)loadWish{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSString *userID = [userDef stringForKey:@"userID"];
    NSDictionary *parameters = @{@"userid":userID,@"page":@"1",@"limit":@"10",@"access_token":token};
    [manager GET:Wish_My_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.WishArr = [Wishmodel mj_objectArrayWithKeyValuesArray:responseObject[@"user"]];
        
        
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
    
    return self.WishArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NSString *ID = [NSString stringWithFormat:@"WishCell"];
    WishTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[WishTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    
    [cell setup:self.WishArr[indexPath.row]];
    cell.selectionStyle =UITableViewCellSelectionStyleNone;
    
    return cell;
}


- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    Wishmodel *model = [self.WishArr objectAtIndex:indexPath.row];
    return [model getCellHeight];
    
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
