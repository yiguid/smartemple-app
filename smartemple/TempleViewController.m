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

    UISearchBar * mySearchBar;
    NSString * searchstring;
    UITapGestureRecognizer *tapGr;
}

@property(nonatomic, strong)NSMutableArray * allTempleArr;
@property(nonatomic, strong)NSMutableArray * recTempleArr;
@property(nonatomic, strong)NSMutableArray * hotTempleArr;
@property(nonatomic, strong)NSMutableArray * searchTempleArr;
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
    self.searchTempleArr = [[NSMutableArray alloc]init];
    
    self.navigationItem.title = @"寺院";
    
    UIColor * color = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
    
    NSDictionary * dict=[NSDictionary dictionaryWithObject:color forKey:NSForegroundColorAttributeName];
    
    self.navigationController.navigationBar.titleTextAttributes = dict;
    
   
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"🔍"
                                    style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(right:)];
    [self.navigationItem setRightBarButtonItem:rightButton];
    
    self.navigationController.navigationBar.tintColor = [UIColor colorWithRed:147/255.0 green:133/255.0 blue:99/255.0 alpha:1.0];
   
    
    mySearchBar = [[UISearchBar alloc]initWithFrame:CGRectMake(0,64, wScreen, 40)];
    mySearchBar.delegate = self;
    mySearchBar.showsBookmarkButton = YES;
    mySearchBar.showsScopeBar = YES;
    
//    mySearchBar.barStyle = UIBarStyleBlackTranslucent;
    mySearchBar.placeholder = @"搜索寺庙";
    [self.view addSubview:mySearchBar];
    
    mySearchBar.hidden = YES;
    
    tapGr = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped:)];

    //键盘弹出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardShow:) name:UIKeyboardWillShowNotification object:nil];
    //键盘隐藏通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardHid:) name: UIKeyboardWillHideNotification object:nil];

    
    [self loadRec];
    [self loadHot];
    [self loadAll];
    
    searchstring = @"";

}

///键盘显示事件
- (void) keyboardShow:(NSNotification *)notification {

    //给最外层的view添加一个手势响应UITapGestureRecognizer
    
       [self.view addGestureRecognizer:tapGr];
    

}
///键盘关闭事件
- (void) keyboardHid:(NSNotification *)notification {

    [self.view removeGestureRecognizer:tapGr];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)right:(id)sender{
    if (mySearchBar.hidden==YES) {
        mySearchBar.hidden=NO;
        self.tableView.frame = CGRectMake(0,40, wScreen, hScreen-40);
    }else{
        mySearchBar.hidden=YES;
        self.tableView.frame = CGRectMake(0,0, wScreen, hScreen);
    }
    
    
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索Begin");
    return YES;
}
- (BOOL)searchBarShouldEndEditing:(UISearchBar *)searchBar{
    NSLog(@"搜索End");
    [mySearchBar resignFirstResponder];
    return YES;
}
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText;
{
    if ([searchText isEqualToString:@""]) {
        searchstring = @"";
    }else{
        searchstring = @"搜索";
    }
    
    NSLog(@"%@",searchText);
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
    NSDictionary *parameters=@{@"page":@"1",@"limit":@"3",@"searchtemple":searchText,@"access_token":token};
    [manager GET:Search_temple_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"%@",responseObject);
        
        self.searchTempleArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        [self.tableView reloadData];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];

    
}
-(void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if ([searchBar.text isEqualToString:@""]) {
        searchstring = @"";
    }else{
        searchstring = @"搜索";
    }

    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
        NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
        NSString *token = [userDef stringForKey:@"token"];
        NSDictionary *parameters=@{@"page":@"1",@"limit":@"3",@"searchtemple":searchBar.text,@"access_token":token};
        [manager GET:Search_temple_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
    
            NSLog(@"%@",responseObject);
            
            self.searchTempleArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
            [self.tableView reloadData];
            
            
            [mySearchBar resignFirstResponder];
    
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"%@",error);
        }];
  

}


-(void)loadRec{
    
     AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
     NSDictionary *parameters = @{@"page": @"1",@"limit":@"5",@"access_token":token};
    [manager GET:Temple_recommend_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.recTempleArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];



}
-(void)loadHot{
    
     AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
     NSDictionary *parameters = @{@"page": @"1",@"limit":@"5",@"access_token":token};
    [manager GET:Temple_hot_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.hotTempleArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];


}
-(void)loadAll{
    
    AFHTTPRequestOperationManager *manager=[AFHTTPRequestOperationManager manager];
    NSUserDefaults *userDef = [NSUserDefaults standardUserDefaults];
    NSString *token = [userDef stringForKey:@"token"];
     NSDictionary *parameters = @{@"page": @"1",@"limit":@"5",@"access_token":token};
    [manager GET:Temple_all_API parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        
        self.allTempleArr = [TempleModel mj_objectArrayWithKeyValuesArray:responseObject[@"temple"]];
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
        
        
    }];
    


}





- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    if ([searchstring isEqualToString:@"搜索"]) {
        return 1;
    }else{
        
        return 3;
    }
  
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
     if ([searchstring isEqualToString:@"搜索"]) {
         return self.searchTempleArr.count;
     }else{
         if (section==0) {
             return self.recTempleArr.count;
         }else if (section==1){
             
             return self.hotTempleArr.count;
         }else{
             
             return self.allTempleArr.count;
         }
     }
    
    
      
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        
        NSString *ID = [NSString stringWithFormat:@"Cell"];
        TempleTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:ID];
        
        if (cell == nil) {
            cell = [[TempleTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
             cell.selectionStyle =UITableViewCellSelectionStyleNone;
        }
    
    
         if ([searchstring isEqualToString:@"搜索"]) {
             
                 [cell setup:self.searchTempleArr[indexPath.row]];
                 cell.selectionStyle =UITableViewCellSelectionStyleNone;
         }else{
             if (indexPath.section==0) {
                 [cell setup:self.recTempleArr[indexPath.row]];
                 cell.selectionStyle =UITableViewCellSelectionStyleNone;
                 
             }else  if (indexPath.section==1) {
                 
                 
                 [cell setup:self.hotTempleArr[indexPath.row]];
                 cell.selectionStyle =UITableViewCellSelectionStyleNone;
                 
                 
             }else{
                 [cell setup:self.allTempleArr[indexPath.row]];
                 cell.selectionStyle =UITableViewCellSelectionStyleNone;
                 
             }

         }
    
    
    
    
    return cell;
    
 
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    
    if ([searchstring isEqualToString:@"搜索"]){
        
    }else{
        if (section==0) {
            return @"推荐寺院";
        }else if (section==1){
            return @"热门寺院";
        }else{
            return @"全部寺院";
        }
    }
    
    return nil;
    
}



- (CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if ([searchstring isEqualToString:@"搜索"]){
        
        TempleModel *model = [self.searchTempleArr objectAtIndex:indexPath.row];
        return [model getCellHeight];
    }else{
        if (indexPath.section==0) {
            TempleModel *model = [self.recTempleArr objectAtIndex:indexPath.row];
            return [model getCellHeight];
        }else if (indexPath.section==1){
            TempleModel *model = [self.hotTempleArr objectAtIndex:indexPath.row];
            return [model getCellHeight];
        }else{
            
            TempleModel *model = [self.allTempleArr objectAtIndex:indexPath.row];
            return [model getCellHeight];
        }
    }

  
    

    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if ([searchstring isEqualToString:@"搜索"]){
        TempleSecondViewController * temple = [[TempleSecondViewController alloc]init];
        
        TempleModel * model = self.searchTempleArr[indexPath.row];
        
        temple.temple = model;
        
        temple.hidesBottomBarWhenPushed = YES;
        
        UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
        self.navigationItem.backBarButtonItem = barButtonItem;
        
        [self.navigationController pushViewController:temple animated:YES];
    }else{
        if (indexPath.section==0) {
            
            TempleSecondViewController * temple = [[TempleSecondViewController alloc]init];
            
            TempleModel * model = self.recTempleArr[indexPath.row];
            
            temple.temple = model;
            
            temple.hidesBottomBarWhenPushed = YES;
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = barButtonItem;
            
            [self.navigationController pushViewController:temple animated:YES];
            
        }else if (indexPath.section==1) {
            
            
            TempleSecondViewController * temple = [[TempleSecondViewController alloc]init];
            
            TempleModel * model = self.hotTempleArr[indexPath.row];
            
            temple.temple = model;
            
            temple.hidesBottomBarWhenPushed = YES;
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = barButtonItem;
            
            [self.navigationController pushViewController:temple animated:YES];
            
        }else{
            
            TempleSecondViewController * temple = [[TempleSecondViewController alloc]init];
            
            TempleModel * model = self.allTempleArr[indexPath.row];
            
            temple.temple = model;
            
            temple.hidesBottomBarWhenPushed = YES;
            
            UIBarButtonItem *barButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStyleDone target:nil action:nil];
            self.navigationItem.backBarButtonItem = barButtonItem;
            
            [self.navigationController pushViewController:temple animated:YES];
            
        }

    }
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [mySearchBar resignFirstResponder];
}

-(void)viewTapped:(UITapGestureRecognizer*)tapGr
{
    
   
     [mySearchBar resignFirstResponder];
    
    
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
