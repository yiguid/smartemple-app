//
//  TempleViewController.m
//  smartemple
//
//  Created by wang on 16/3/2.
//  Copyright © 2016年 wang. All rights reserved.
//

#import "TempleViewController.h"
#import "smartemple.pch"
#import "TempleModel.h"
#import "TempleTableViewCell.h"
#import "TempleSecondViewController.h"
#import "AFNetworking.h"
#import "MJExtension.h"
#import "UIImageView+WebCache.h"
@interface TempleViewController (){

     UISearchBar * mysearch;
}

@property(nonatomic, strong)NSMutableArray * allTempleArr;
@property(nonatomic, strong)NSMutableArray * recTempleArr;
@property(nonatomic, strong)NSMutableArray * hotTempleArr;

@end

@implementation TempleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, wScreen, hScreen) style:UITableViewStylePlain];
    _tableView.delegate=self;
    _tableView.dataSource=self;
    _tableView.separatorStyle=UITableViewCellSelectionStyleNone;
    [self.view addSubview:_tableView];
    
    self.allTempleArr = [[NSMutableArray alloc]init];
    self.recTempleArr = [[NSMutableArray alloc]init];
    self.hotTempleArr = [[NSMutableArray alloc]init];
    
     self.navigationItem.title = @"寺院";
    
    UIColor * color = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
//    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc]
//                                   initWithTitle:@"左按钮"
//                                   style:UIBarButtonItemStylePlain
//                                   target:self
//                                   action:@selector(left)];
//    [self.navigationItem setLeftBarButtonItem:leftButton];
//    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"🔍"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(right:)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];

    mysearch = [[UISearchBar alloc]initWithFrame:CGRectMake(0,64,wScreen, 40)];
    
    mysearch.delegate = self;
    
    mysearch.placeholder = @"搜索寺院";
    mysearch.barTintColor = [UIColor colorWithRed:190/255.0 green:160/255.0 blue:110/255.0 alpha:1.0];
    

    [self.view addSubview:mysearch];
    mysearch.hidden = YES;

    
    
    [self loadData];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)right:(id)sender{
    if (mysearch.hidden==YES) {
        mysearch.hidden=NO;
        self.tableView.frame = CGRectMake(0,40, wScreen, hScreen-40);
    }else{
        mysearch.hidden=YES;
        self.tableView.frame = CGRectMake(0,0, wScreen, hScreen);
    }
    
    
}

-(BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    
    NSLog(@"shouldBeginEditing");
    return YES;
    
}
-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"didBeginEditing");
    
}
-(BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"shouldEndEding");
    return YES;
}
-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    NSLog(@"didEndEditing");
}

-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    NSLog(@"searchButtonClicked");
    
}


- (void)loadData{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    
    [manager GET:Temple_all_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.allTempleArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
         [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    [manager GET:Temple_hot_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.hotTempleArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    
    [manager GET:Temple_recommend_API parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.recTempleArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];



    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section==0) {
        return self.recTempleArr.count;
    }else if (section==1){
    
        return self.hotTempleArr.count;
    }else{
    
        return self.allTempleArr.count;
    }
    
  
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
        NSString *ID = [NSString stringWithFormat:@"Cell"];
        TempleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[TempleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
             cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
    
    if (indexPath.section==0) {
                [cell setup:self.recTempleArr[indexPath.row]];
        
           }else  if (indexPath.section==1) {
               
             
                [cell setup:self.hotTempleArr[indexPath.row]];
                cell.selectionStyle =UITableViewCellSelectionStyleNone;
   

    }else{
                [cell setup:self.allTempleArr[indexPath.row]];
                 cell.selectionStyle =UITableViewCellSelectionStyleNone;
        
          }
    
    return cell;
    
 
}
- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    return 300;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    TempleSecondViewController * temple = [[TempleSecondViewController alloc]init];
    
    temple.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:temple animated:YES];


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
